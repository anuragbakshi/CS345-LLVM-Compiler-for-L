; ModuleID = 'top'

%struct.Object = type { i8*, i8* }

@0 = private unnamed_addr constant [5 x i8] c"true\00"
@1 = private unnamed_addr constant [6 x i8] c"false\00"

define i32 @main() {
entrypoint:
  %0 = call %struct.Object* @make_int(i64 0)
  %1 = call i1 @assert_predicate(%struct.Object* %0)
  br i1 %1, label %if, label %else

if:                                               ; preds = %entrypoint
  %2 = call %struct.Object* @make_string(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @0, i32 0, i32 0))
  %3 = call %struct.Object* @print_any(%struct.Object* %2)
  br label %after

else:                                             ; preds = %entrypoint
  %4 = call %struct.Object* @make_string(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @1, i32 0, i32 0))
  %5 = call %struct.Object* @print_any(%struct.Object* %4)
  br label %after

after:                                            ; preds = %else, %if
  %6 = phi %struct.Object* [ %3, %if ], [ %5, %else ]
  call void @display_any(%struct.Object* %6)
  ret i32 0
}

declare %struct.Object* @read_line()

declare %struct.Object* @read_int()

declare %struct.Object* @make_int(i64)

declare %struct.Object* @make_string(i8*)

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
