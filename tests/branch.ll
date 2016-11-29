; ModuleID = 'top'

%struct.Object = type { i8*, i8* }

define i32 @main() {
entrypoint:
  %0 = call i8* @symboltable_new()
  %1 = call %struct.Object* @make_int(i64 20)
  %2 = call %struct.Object* @print_any(%struct.Object* %1)
  %3 = call i1 @assert_predicate(%struct.Object* %2)
  br i1 %3, label %if, label %else

if:                                               ; preds = %entrypoint
  %4 = call %struct.Object* @make_int(i64 5)
  br label %after

else:                                             ; preds = %entrypoint
  %5 = call %struct.Object* @make_int(i64 21)
  %6 = call %struct.Object* @print_any(%struct.Object* %5)
  br label %after

after:                                            ; preds = %else, %if
  %7 = phi %struct.Object* [ %4, %if ], [ %6, %else ]
  %8 = call i1 @assert_predicate(%struct.Object* %7)
  br i1 %8, label %if1, label %else2

if1:                                              ; preds = %after
  %9 = call %struct.Object* @make_int(i64 22)
  %10 = call %struct.Object* @print_any(%struct.Object* %9)
  br label %after3

else2:                                            ; preds = %after
  %11 = call %struct.Object* @make_int(i64 4)
  %12 = call i1 @assert_predicate(%struct.Object* %11)
  br i1 %12, label %if4, label %else5

after3:                                           ; preds = %after6, %if1
  %13 = phi %struct.Object* [ %10, %if1 ], [ %18, %after6 ]
  %14 = call i1 @assert_predicate(%struct.Object* %13)
  br i1 %14, label %if7, label %else8

if4:                                              ; preds = %else2
  %15 = call %struct.Object* @make_int(i64 23)
  %16 = call %struct.Object* @print_any(%struct.Object* %15)
  br label %after6

else5:                                            ; preds = %else2
  %17 = call %struct.Object* @make_int(i64 1)
  br label %after6

after6:                                           ; preds = %else5, %if4
  %18 = phi %struct.Object* [ %16, %if4 ], [ %17, %else5 ]
  br label %after3

if7:                                              ; preds = %after3
  %19 = call %struct.Object* @make_int(i64 24)
  %20 = call %struct.Object* @print_any(%struct.Object* %19)
  %21 = call i1 @assert_predicate(%struct.Object* %20)
  br i1 %21, label %if10, label %else11

else8:                                            ; preds = %after3
  %22 = call %struct.Object* @make_int(i64 6)
  %23 = call i1 @assert_predicate(%struct.Object* %22)
  br i1 %23, label %if13, label %else14

after9:                                           ; preds = %after15, %after12
  %24 = phi %struct.Object* [ %27, %after12 ], [ %32, %after15 ]
  call void @display_any(%struct.Object* %24)
  ret i32 0

if10:                                             ; preds = %if7
  %25 = call %struct.Object* @make_int(i64 3)
  br label %after12

else11:                                           ; preds = %if7
  %26 = call %struct.Object* @make_int(i64 2)
  br label %after12

after12:                                          ; preds = %else11, %if10
  %27 = phi %struct.Object* [ %25, %if10 ], [ %26, %else11 ]
  br label %after9

if13:                                             ; preds = %else8
  %28 = call %struct.Object* @make_int(i64 25)
  %29 = call %struct.Object* @print_any(%struct.Object* %28)
  br label %after15

else14:                                           ; preds = %else8
  %30 = call %struct.Object* @make_int(i64 26)
  %31 = call %struct.Object* @print_any(%struct.Object* %30)
  br label %after15

after15:                                          ; preds = %else14, %if13
  %32 = phi %struct.Object* [ %29, %if13 ], [ %31, %else14 ]
  br label %after9
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
