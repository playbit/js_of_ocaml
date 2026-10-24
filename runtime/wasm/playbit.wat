;; Standalone lifecycle only. Syscall primitives are supplied by the app SDK.
(module
    (type $bytes (array (mut i8)))
    (import "OCaml" "_initialize" (func $initialize))
    (import "stdlib" "caml_named_value"
        (func $named (param (ref eq)) (result (ref null eq))))
    (import "obj" "caml_callback_1"
        (func $callback (param (ref eq) (ref eq)) (result (ref eq))))
    (memory (export "memory") 1)
    (global $initialized (mut i32) (i32.const 0))
    (@string $turn "playbit.turn")
    (func (export "pb_main")
        ;; 1 means initialization/callback is in progress; traps halt the guest.
        (if (i32.eq (global.get $initialized) (i32.const 1)) (then unreachable))
        (if (i32.eqz (global.get $initialized))
            (then
                (global.set $initialized (i32.const 1))
                (call $initialize)))
        (global.set $initialized (i32.const 1))
        (drop (call $callback (ref.as_non_null (call $named (global.get $turn)))
            (ref.i31 (i32.const 0))))
        (global.set $initialized (i32.const 2)))
)
