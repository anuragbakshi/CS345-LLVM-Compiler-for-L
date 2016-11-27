; ModuleID = 'top'

%struct.Object = type { i8*, i8* }

define i32 @main() {
entrypoint:
  %0 = call %struct.Object* @make_int(i64 5)
  %1 = call %struct.Object* @make_int(i64 4)
  %2 = call %struct.Object* @plus_any(%struct.Object* %0, %struct.Object* %1)
  call void @print_any(%struct.Object* %2)
  ret i32 0
}

declare %struct.Object* @read_line()

declare %struct.Object* @read_int()

declare %struct.Object* @make_int(i64)

declare %struct.Object* @plus_any(%struct.Object*, %struct.Object*)

declare void @print_any(%struct.Object*)
