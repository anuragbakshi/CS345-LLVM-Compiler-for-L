; ModuleID = 'top'

%struct.Object = type { i8*, i8* }

define i32 @main() {
entrypoint:
  %0 = call %struct.Object* @make_int(i64 1)
  %1 = call %struct.Object* @make_int(i64 2)
  %2 = call %struct.Object* @times_any(%struct.Object* %0, %struct.Object* %1)
  %3 = call %struct.Object* @make_int(i64 3)
  %4 = call %struct.Object* @times_any(%struct.Object* %2, %struct.Object* %3)
  %5 = call %struct.Object* @make_int(i64 4)
  %6 = call %struct.Object* @times_any(%struct.Object* %4, %struct.Object* %5)
  %7 = call %struct.Object* @make_int(i64 5)
  %8 = call %struct.Object* @times_any(%struct.Object* %6, %struct.Object* %7)
  %9 = call %struct.Object* @make_int(i64 6)
  %10 = call %struct.Object* @times_any(%struct.Object* %8, %struct.Object* %9)
  %11 = call %struct.Object* @make_int(i64 7)
  %12 = call %struct.Object* @times_any(%struct.Object* %10, %struct.Object* %11)
  %13 = call %struct.Object* @make_int(i64 8)
  %14 = call %struct.Object* @times_any(%struct.Object* %12, %struct.Object* %13)
  %15 = call %struct.Object* @make_int(i64 9)
  %16 = call %struct.Object* @times_any(%struct.Object* %14, %struct.Object* %15)
  %17 = call %struct.Object* @make_int(i64 10)
  %18 = call %struct.Object* @times_any(%struct.Object* %16, %struct.Object* %17)
  call void @display_any(%struct.Object* %18)
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
