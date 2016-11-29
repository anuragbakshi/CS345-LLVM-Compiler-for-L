; ModuleID = 'top'

%struct.Object = type { i8*, i8* }

@0 = private unnamed_addr constant [6 x i8] c"hello\00"
@1 = private unnamed_addr constant [2 x i8] c" \00"
@2 = private unnamed_addr constant [6 x i8] c"world\00"

define i32 @main() {
entrypoint:
  %0 = call i8* @symboltable_new()
  %1 = call %struct.Object* @make_string(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @0, i32 0, i32 0))
  %2 = call %struct.Object* @make_string(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @1, i32 0, i32 0))
  %3 = call %struct.Object* @plus_any(%struct.Object* %1, %struct.Object* %2)
  %4 = call %struct.Object* @make_string(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @2, i32 0, i32 0))
  %5 = call %struct.Object* @plus_any(%struct.Object* %3, %struct.Object* %4)
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
