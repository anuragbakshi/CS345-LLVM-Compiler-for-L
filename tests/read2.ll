; ModuleID = 'top'

%struct.Object = type { i8*, i8* }

define i32 @main() {
entrypoint:
  %0 = call i8* @symboltable_new()
  %1 = call %struct.Object* @read_int()
  %2 = call i1 @assert_predicate(%struct.Object* %1)
  br i1 %2, label %if, label %else

if:                                               ; preds = %entrypoint
  %3 = call %struct.Object* @read_int()
  br label %after

else:                                             ; preds = %entrypoint
  %4 = call %struct.Object* @read_string()
  br label %after

after:                                            ; preds = %else, %if
  %5 = phi %struct.Object* [ %3, %if ], [ %4, %else ]
  call void @display_any(%struct.Object* %5)
  ret i32 0
}

declare %struct.Object* @read_string()

declare %struct.Object* @read_int()

declare %struct.Object* @make_int(i64)

declare %struct.Object* @make_string(i8*)

declare %struct.Object* @make_nil()

declare i1 @assert_predicate(%struct.Object*)

declare %struct.Object* @plus_any(%struct.Object*, %struct.Object*)

declare %struct.Object* @minus_any(%struct.Object*, %struct.Object*)

declare %struct.Object* @times_any(%struct.Object*, %struct.Object*)

declare %struct.Object* @divide_any(%struct.Object*, %struct.Object*)

declare %struct.Object* @and_any(%struct.Object*, %struct.Object*)

declare %struct.Object* @or_any(%struct.Object*, %struct.Object*)

declare %struct.Object* @eq_any(%struct.Object*, %struct.Object*)

declare %struct.Object* @neq_any(%struct.Object*, %struct.Object*)

declare %struct.Object* @lt_any(%struct.Object*, %struct.Object*)

declare %struct.Object* @leq_any(%struct.Object*, %struct.Object*)

declare %struct.Object* @gt_any(%struct.Object*, %struct.Object*)

declare %struct.Object* @geq_any(%struct.Object*, %struct.Object*)

declare %struct.Object* @cons_any(%struct.Object*, %struct.Object*)

declare %struct.Object* @hd_any(%struct.Object*)

declare %struct.Object* @tl_any(%struct.Object*)

declare %struct.Object* @isnil_any(%struct.Object*)

declare %struct.Object* @print_any(%struct.Object*)

declare void @display_any(%struct.Object*)

declare i8* @symboltable_new()

declare void @symboltable_push(i8*, i8*, %struct.Object*)

declare void @symboltable_pop(i8*, i8*)

declare %struct.Object* @symboltable_find(i8*, i8*)

declare void @symboltable_free(i8*)

declare void @debug_print()
