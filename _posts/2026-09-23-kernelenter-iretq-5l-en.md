---
layout: single
title: "Why KernelEnter→iretq blew up with #UD"
date: 2026-09-23 20:00:00 +0800
categories:
author_profile: true
share: true
locale: en
ref: kernelenter-iretq
permalink: /en/kernelenter-iretq-5l/
excerpt: "I wanted kernel tasks to run with IF=1 by switching KernelEnter from a jump to iretq. On the NUC that meant sticky window drags, store remove hangs, #UD/#PF, and sometimes a full Reset. Goal clear; road ugly."
---

## Symptom

I wanted kernel tasks under `IF=1`: change `KernelEnter` from “jump in” to `iretq` restore, aligned with user preemption. On the NUC that meant sticky drags, `store remove` hangs, `#UD` / `#PF`, sometimes a full Reset. Goal clear; road ugly.

## First hypothesis

Simple: if `KernelEnter` uses `iretq`, RFLAGS brings IF, IRQs can enter, input and block devices stop starving in long critical sections. `jmp` into the kernel had pinned tasks in a world with interrupts off — that matched a starved InputTask and frozen mouse during package install/remove.

## Tries and failures

Bare `iretq` on NUC `#PF`’d in `PickNext` reading idle state, then combo Reset. Negated: “flip one entry instruction and done.”

Then one hypothesis per knife: harden idle pointers, checks, drop outer cli in PickNext, kernel-only `NeedResched` + CondResched at Breath, PreemptDisable around StoreRemove, `IrqSave` on block IO, Breath without yield… each knife killed a story that had looked plausible:

- Drop full-path cli: drag better, remove can still hang — not “cli alone.”  
- Soft resched + CondResched: ~1s whole-system stalls like waiting a tick in `hlt` — path out.  
- “remove hangs because hard preempt breaks Fat/Store”: still hangs with preemption disabled — falsified.  
- Wide cli in the block layer: still hangs, timeouts suspected.  
- Serial breadcrumbs: after `rm:in`, a storm of `PickNext bad idle`, then MSC bulk failure.  
- `gIdleSlot` stopped the bad-idle storm, then `#UD` appeared — corrupt idle was real, not the last bone.

I kept those failures: they show `IF=1 + iretq` is not a switch — a whole restore story must be correct together.

## Turning point

The turn put `#UD` and stack layout on one page. Hardware expects a frame layout when `iretq` pops from the kernel stack; that is not “whatever I thought StackTop was.” Missing a fake-return slot misaligns RSP; popped CS/SS/RIP become garbage — `#UD` now or a weirder `#GP` later.

## Root cause

**`iretq` entry lacked a fake return; RSP must sit at `StackTop-8`.** Without that 8-byte slot the frame is wrong from the start. Earlier stutter, bad idle, even some `#PF`s were concurrency noise or downstream of stack semantics. With the fake return and a fixed `gIdleSlot`, NUC `store remove demopack` finishes, and the mouse stays alive across install/remove.

## Lessons

- Global preempt / `KernelEnter`→`iretq` must not share a knife with big NIC work; one interrupt-model change tangles every IO symptom.  
- One hypothesis per knife; write what you negated — “turn iretq on again” is not a hypothesis.  
- Entry instruction, stack frame, idle lifetime, and disable scope are four lines; fixing one does not go green.  
- Real-machine test is mandatory: QEMU can pass and NUC still `#UD`. The last serial line often beats guessing.
