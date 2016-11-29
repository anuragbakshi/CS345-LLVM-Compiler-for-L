; ModuleID = 'top'

%struct.Object = type { i8*, i8* }

define i32 @main() {
entrypoint:
  %0 = call i8* @symboltable_new()
  %1 = call %struct.Object* @make_int(i64 1)
  %2 = call %struct.Object* @make_int(i64 2)
  %3 = call %struct.Object* @times_any(%struct.Object* %1, %struct.Object* %2)
  %4 = call %struct.Object* @make_int(i64 3)
  %5 = call %struct.Object* @times_any(%struct.Object* %3, %struct.Object* %4)
  %6 = call %struct.Object* @make_int(i64 4)
  %7 = call %struct.Object* @times_any(%struct.Object* %5, %struct.Object* %6)
  %8 = call %struct.Object* @make_int(i64 5)
  %9 = call %struct.Object* @times_any(%struct.Object* %7, %struct.Object* %8)
  %10 = call %struct.Object* @make_int(i64 6)
  %11 = call %struct.Object* @times_any(%struct.Object* %9, %struct.Object* %10)
  %12 = call %struct.Object* @make_int(i64 7)
  %13 = call %struct.Object* @times_any(%struct.Object* %11, %struct.Object* %12)
  %14 = call %struct.Object* @make_int(i64 8)
  %15 = call %struct.Object* @times_any(%struct.Object* %13, %struct.Object* %14)
  %16 = call %struct.Object* @make_int(i64 9)
  %17 = call %struct.Object* @times_any(%struct.Object* %15, %struct.Object* %16)
  %18 = call %struct.Object* @make_int(i64 10)
  %19 = call %struct.Object* @times_any(%struct.Object* %17, %struct.Object* %18)
  call void @display_any(%struct.Object* %19)
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
