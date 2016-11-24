; ModuleID = 'util.c'
source_filename = "util.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.11.0"

%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct.Object = type { %union.anon, %union.anon.0 }
%union.anon = type { %struct.Object* }
%union.anon.0 = type { i64 }

@.str = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@__stdinp = external global %struct.__sFILE*, align 8
@.str.1 = private unnamed_addr constant [54 x i8] c"Binop can only be applied to expressions of same type\00", align 1
@.str.2 = private unnamed_addr constant [8 x i8] c"not int\00", align 1
@.str.3 = private unnamed_addr constant [9 x i8] c"not list\00", align 1
@.str.4 = private unnamed_addr constant [6 x i8] c"%lld\0A\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"[\00", align 1
@.str.6 = private unnamed_addr constant [3 x i8] c", \00", align 1
@.str.7 = private unnamed_addr constant [3 x i8] c"]\0A\00", align 1
@.str.8 = private unnamed_addr constant [5 x i8] c"Nil\0A\00", align 1
@.str.9 = private unnamed_addr constant [15 x i8] c"what the fuck\0A\00", align 1
@.str.10 = private unnamed_addr constant [4 x i8] c"hi\0A\00", align 1

; Function Attrs: nounwind ssp uwtable
define void @error(i8*) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i8* %3)
  call void @exit(i32 -1) #5
  unreachable
                                                  ; No predecessors!
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noreturn
declare void @exit(i32) #2

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @makeInt(i64) #0 {
  %2 = alloca i64, align 8
  %3 = alloca %struct.Object*, align 8
  store i64 %0, i64* %2, align 8
  %4 = call i8* @malloc(i64 16)
  %5 = bitcast i8* %4 to %struct.Object*
  store %struct.Object* %5, %struct.Object** %3, align 8
  %6 = load %struct.Object*, %struct.Object** %3, align 8
  %7 = getelementptr inbounds %struct.Object, %struct.Object* %6, i32 0, i32 0
  %8 = bitcast %union.anon* %7 to i32*
  store i32 1, i32* %8, align 8
  %9 = load i64, i64* %2, align 8
  %10 = load %struct.Object*, %struct.Object** %3, align 8
  %11 = getelementptr inbounds %struct.Object, %struct.Object* %10, i32 0, i32 1
  %12 = bitcast %union.anon.0* %11 to i64*
  store i64 %9, i64* %12, align 8
  %13 = load %struct.Object*, %struct.Object** %3, align 8
  ret %struct.Object* %13
}

declare i8* @malloc(i64) #1

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @makeString(i8*) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca %struct.Object*, align 8
  store i8* %0, i8** %2, align 8
  %4 = call i8* @malloc(i64 16)
  %5 = bitcast i8* %4 to %struct.Object*
  store %struct.Object* %5, %struct.Object** %3, align 8
  %6 = load i8*, i8** %2, align 8
  %7 = load %struct.Object*, %struct.Object** %3, align 8
  %8 = getelementptr inbounds %struct.Object, %struct.Object* %7, i32 0, i32 1
  %9 = bitcast %union.anon.0* %8 to i8**
  store i8* %6, i8** %9, align 8
  %10 = load %struct.Object*, %struct.Object** %3, align 8
  %11 = getelementptr inbounds %struct.Object, %struct.Object* %10, i32 0, i32 0
  %12 = bitcast %union.anon* %11 to i32*
  store i32 2, i32* %12, align 8
  %13 = load %struct.Object*, %struct.Object** %3, align 8
  ret %struct.Object* %13
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @makeList(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  %5 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %6 = call i8* @malloc(i64 16)
  %7 = bitcast i8* %6 to %struct.Object*
  store %struct.Object* %7, %struct.Object** %5, align 8
  %8 = load %struct.Object*, %struct.Object** %3, align 8
  %9 = load %struct.Object*, %struct.Object** %5, align 8
  %10 = getelementptr inbounds %struct.Object, %struct.Object* %9, i32 0, i32 0
  %11 = bitcast %union.anon* %10 to %struct.Object**
  store %struct.Object* %8, %struct.Object** %11, align 8
  %12 = load %struct.Object*, %struct.Object** %4, align 8
  %13 = load %struct.Object*, %struct.Object** %5, align 8
  %14 = getelementptr inbounds %struct.Object, %struct.Object* %13, i32 0, i32 1
  %15 = bitcast %union.anon.0* %14 to %struct.Object**
  store %struct.Object* %12, %struct.Object** %15, align 8
  %16 = load %struct.Object*, %struct.Object** %5, align 8
  ret %struct.Object* %16
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @readString() #0 {
  %1 = alloca i8*, align 8
  %2 = load %struct.__sFILE*, %struct.__sFILE** @__stdinp, align 8
  %3 = call i64 @getline(i8** %1, i64* null, %struct.__sFILE* %2)
  %4 = load i8*, i8** %1, align 8
  %5 = call %struct.Object* @makeString(i8* %4)
  ret %struct.Object* %5
}

declare i64 @getline(i8**, i64*, %struct.__sFILE*) #1

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @readInt() #0 {
  %1 = alloca i8*, align 8
  %2 = load %struct.__sFILE*, %struct.__sFILE** @__stdinp, align 8
  %3 = call i64 @getline(i8** %1, i64* null, %struct.__sFILE* %2)
  %4 = load i8*, i8** %1, align 8
  %5 = call i32 @atoi(i8* %4)
  %6 = sext i32 %5 to i64
  %7 = call %struct.Object* @makeInt(i64 %6)
  ret %struct.Object* %7
}

declare i32 @atoi(i8*) #1

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @add_str(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  %5 = alloca i8*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %6 = load %struct.Object*, %struct.Object** %3, align 8
  %7 = getelementptr inbounds %struct.Object, %struct.Object* %6, i32 0, i32 1
  %8 = bitcast %union.anon.0* %7 to i8**
  %9 = load i8*, i8** %8, align 8
  %10 = call i64 @strlen(i8* %9)
  %11 = load %struct.Object*, %struct.Object** %4, align 8
  %12 = getelementptr inbounds %struct.Object, %struct.Object* %11, i32 0, i32 1
  %13 = bitcast %union.anon.0* %12 to i8**
  %14 = load i8*, i8** %13, align 8
  %15 = call i64 @strlen(i8* %14)
  %16 = add i64 %10, %15
  %17 = add i64 %16, 1
  %18 = call i8* @malloc(i64 %17)
  store i8* %18, i8** %5, align 8
  %19 = load i8*, i8** %5, align 8
  %20 = load %struct.Object*, %struct.Object** %3, align 8
  %21 = getelementptr inbounds %struct.Object, %struct.Object* %20, i32 0, i32 1
  %22 = bitcast %union.anon.0* %21 to i8**
  %23 = load i8*, i8** %22, align 8
  %24 = load i8*, i8** %5, align 8
  %25 = call i64 @llvm.objectsize.i64.p0i8(i8* %24, i1 false)
  %26 = call i8* @__strcpy_chk(i8* %19, i8* %23, i64 %25) #6
  %27 = load i8*, i8** %5, align 8
  %28 = load %struct.Object*, %struct.Object** %4, align 8
  %29 = getelementptr inbounds %struct.Object, %struct.Object* %28, i32 0, i32 1
  %30 = bitcast %union.anon.0* %29 to i8**
  %31 = load i8*, i8** %30, align 8
  %32 = load i8*, i8** %5, align 8
  %33 = call i64 @llvm.objectsize.i64.p0i8(i8* %32, i1 false)
  %34 = call i8* @__strcat_chk(i8* %27, i8* %31, i64 %33) #6
  %35 = load i8*, i8** %5, align 8
  %36 = call %struct.Object* @makeString(i8* %35)
  ret %struct.Object* %36
}

declare i64 @strlen(i8*) #1

; Function Attrs: nounwind
declare i8* @__strcpy_chk(i8*, i8*, i64) #3

; Function Attrs: nounwind readnone
declare i64 @llvm.objectsize.i64.p0i8(i8*, i1) #4

; Function Attrs: nounwind
declare i8* @__strcat_chk(i8*, i8*, i64) #3

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @add_int(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  %5 = alloca i64, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %6 = load %struct.Object*, %struct.Object** %3, align 8
  %7 = getelementptr inbounds %struct.Object, %struct.Object* %6, i32 0, i32 1
  %8 = bitcast %union.anon.0* %7 to i64*
  %9 = load i64, i64* %8, align 8
  %10 = load %struct.Object*, %struct.Object** %4, align 8
  %11 = getelementptr inbounds %struct.Object, %struct.Object* %10, i32 0, i32 1
  %12 = bitcast %union.anon.0* %11 to i64*
  %13 = load i64, i64* %12, align 8
  %14 = add i64 %9, %13
  store i64 %14, i64* %5, align 8
  %15 = load i64, i64* %5, align 8
  %16 = call %struct.Object* @makeInt(i64 %15)
  ret %struct.Object* %16
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @add_any(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  %5 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %4, align 8
  store %struct.Object* %1, %struct.Object** %5, align 8
  %6 = load %struct.Object*, %struct.Object** %4, align 8
  %7 = getelementptr inbounds %struct.Object, %struct.Object* %6, i32 0, i32 0
  %8 = bitcast %union.anon* %7 to i32*
  %9 = load i32, i32* %8, align 8
  %10 = icmp eq i32 %9, 1
  br i1 %10, label %11, label %21

; <label>:11                                      ; preds = %2
  %12 = load %struct.Object*, %struct.Object** %5, align 8
  %13 = getelementptr inbounds %struct.Object, %struct.Object* %12, i32 0, i32 0
  %14 = bitcast %union.anon* %13 to i32*
  %15 = load i32, i32* %14, align 8
  %16 = icmp eq i32 %15, 1
  br i1 %16, label %17, label %21

; <label>:17                                      ; preds = %11
  %18 = load %struct.Object*, %struct.Object** %4, align 8
  %19 = load %struct.Object*, %struct.Object** %5, align 8
  %20 = call %struct.Object* @add_int(%struct.Object* %18, %struct.Object* %19)
  store %struct.Object* %20, %struct.Object** %3, align 8
  br label %40

; <label>:21                                      ; preds = %11, %2
  %22 = load %struct.Object*, %struct.Object** %4, align 8
  %23 = getelementptr inbounds %struct.Object, %struct.Object* %22, i32 0, i32 0
  %24 = bitcast %union.anon* %23 to i32*
  %25 = load i32, i32* %24, align 8
  %26 = icmp eq i32 %25, 2
  br i1 %26, label %27, label %37

; <label>:27                                      ; preds = %21
  %28 = load %struct.Object*, %struct.Object** %5, align 8
  %29 = getelementptr inbounds %struct.Object, %struct.Object* %28, i32 0, i32 0
  %30 = bitcast %union.anon* %29 to i32*
  %31 = load i32, i32* %30, align 8
  %32 = icmp eq i32 %31, 2
  br i1 %32, label %33, label %37

; <label>:33                                      ; preds = %27
  %34 = load %struct.Object*, %struct.Object** %4, align 8
  %35 = load %struct.Object*, %struct.Object** %5, align 8
  %36 = call %struct.Object* @add_str(%struct.Object* %34, %struct.Object* %35)
  store %struct.Object* %36, %struct.Object** %3, align 8
  br label %40

; <label>:37                                      ; preds = %27, %21
  call void @error(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.1, i32 0, i32 0))
  br label %38

; <label>:38                                      ; preds = %37
  br label %39

; <label>:39                                      ; preds = %38
  store %struct.Object* null, %struct.Object** %3, align 8
  br label %40

; <label>:40                                      ; preds = %39, %33, %17
  %41 = load %struct.Object*, %struct.Object** %3, align 8
  ret %struct.Object* %41
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @eq_int(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  %5 = alloca i64, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %6 = load %struct.Object*, %struct.Object** %3, align 8
  %7 = getelementptr inbounds %struct.Object, %struct.Object* %6, i32 0, i32 1
  %8 = bitcast %union.anon.0* %7 to i64*
  %9 = load i64, i64* %8, align 8
  %10 = load %struct.Object*, %struct.Object** %4, align 8
  %11 = getelementptr inbounds %struct.Object, %struct.Object* %10, i32 0, i32 1
  %12 = bitcast %union.anon.0* %11 to i64*
  %13 = load i64, i64* %12, align 8
  %14 = icmp eq i64 %9, %13
  %15 = zext i1 %14 to i32
  %16 = sext i32 %15 to i64
  store i64 %16, i64* %5, align 8
  %17 = load i64, i64* %5, align 8
  %18 = call %struct.Object* @makeInt(i64 %17)
  ret %struct.Object* %18
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @eq_str(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  %5 = alloca i64, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %6 = load %struct.Object*, %struct.Object** %3, align 8
  %7 = getelementptr inbounds %struct.Object, %struct.Object* %6, i32 0, i32 1
  %8 = bitcast %union.anon.0* %7 to i8**
  %9 = load i8*, i8** %8, align 8
  %10 = load %struct.Object*, %struct.Object** %4, align 8
  %11 = getelementptr inbounds %struct.Object, %struct.Object* %10, i32 0, i32 1
  %12 = bitcast %union.anon.0* %11 to i8**
  %13 = load i8*, i8** %12, align 8
  %14 = call i32 @strcmp(i8* %9, i8* %13)
  %15 = sext i32 %14 to i64
  store i64 %15, i64* %5, align 8
  %16 = load i64, i64* %5, align 8
  %17 = call %struct.Object* @makeInt(i64 %16)
  ret %struct.Object* %17
}

declare i32 @strcmp(i8*, i8*) #1

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @eq_any(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  %5 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %4, align 8
  store %struct.Object* %1, %struct.Object** %5, align 8
  %6 = load %struct.Object*, %struct.Object** %4, align 8
  %7 = getelementptr inbounds %struct.Object, %struct.Object* %6, i32 0, i32 0
  %8 = bitcast %union.anon* %7 to i32*
  %9 = load i32, i32* %8, align 8
  %10 = icmp eq i32 %9, 1
  br i1 %10, label %11, label %21

; <label>:11                                      ; preds = %2
  %12 = load %struct.Object*, %struct.Object** %5, align 8
  %13 = getelementptr inbounds %struct.Object, %struct.Object* %12, i32 0, i32 0
  %14 = bitcast %union.anon* %13 to i32*
  %15 = load i32, i32* %14, align 8
  %16 = icmp eq i32 %15, 1
  br i1 %16, label %17, label %21

; <label>:17                                      ; preds = %11
  %18 = load %struct.Object*, %struct.Object** %4, align 8
  %19 = load %struct.Object*, %struct.Object** %5, align 8
  %20 = call %struct.Object* @eq_int(%struct.Object* %18, %struct.Object* %19)
  store %struct.Object* %20, %struct.Object** %3, align 8
  br label %40

; <label>:21                                      ; preds = %11, %2
  %22 = load %struct.Object*, %struct.Object** %4, align 8
  %23 = getelementptr inbounds %struct.Object, %struct.Object* %22, i32 0, i32 0
  %24 = bitcast %union.anon* %23 to i32*
  %25 = load i32, i32* %24, align 8
  %26 = icmp eq i32 %25, 2
  br i1 %26, label %27, label %37

; <label>:27                                      ; preds = %21
  %28 = load %struct.Object*, %struct.Object** %5, align 8
  %29 = getelementptr inbounds %struct.Object, %struct.Object* %28, i32 0, i32 0
  %30 = bitcast %union.anon* %29 to i32*
  %31 = load i32, i32* %30, align 8
  %32 = icmp eq i32 %31, 2
  br i1 %32, label %33, label %37

; <label>:33                                      ; preds = %27
  %34 = load %struct.Object*, %struct.Object** %4, align 8
  %35 = load %struct.Object*, %struct.Object** %5, align 8
  %36 = call %struct.Object* @eq_int(%struct.Object* %34, %struct.Object* %35)
  store %struct.Object* %36, %struct.Object** %3, align 8
  br label %40

; <label>:37                                      ; preds = %27, %21
  call void @error(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.1, i32 0, i32 0))
  br label %38

; <label>:38                                      ; preds = %37
  br label %39

; <label>:39                                      ; preds = %38
  store %struct.Object* null, %struct.Object** %3, align 8
  br label %40

; <label>:40                                      ; preds = %39, %33, %17
  %41 = load %struct.Object*, %struct.Object** %3, align 8
  ret %struct.Object* %41
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @neq_int(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  %5 = alloca i64, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %6 = load %struct.Object*, %struct.Object** %3, align 8
  %7 = getelementptr inbounds %struct.Object, %struct.Object* %6, i32 0, i32 1
  %8 = bitcast %union.anon.0* %7 to i64*
  %9 = load i64, i64* %8, align 8
  %10 = load %struct.Object*, %struct.Object** %4, align 8
  %11 = getelementptr inbounds %struct.Object, %struct.Object* %10, i32 0, i32 1
  %12 = bitcast %union.anon.0* %11 to i64*
  %13 = load i64, i64* %12, align 8
  %14 = icmp ne i64 %9, %13
  %15 = zext i1 %14 to i32
  %16 = sext i32 %15 to i64
  store i64 %16, i64* %5, align 8
  %17 = load i64, i64* %5, align 8
  %18 = call %struct.Object* @makeInt(i64 %17)
  ret %struct.Object* %18
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @neq_str(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  %5 = alloca i64, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %6 = load %struct.Object*, %struct.Object** %3, align 8
  %7 = getelementptr inbounds %struct.Object, %struct.Object* %6, i32 0, i32 1
  %8 = bitcast %union.anon.0* %7 to i8**
  %9 = load i8*, i8** %8, align 8
  %10 = load %struct.Object*, %struct.Object** %4, align 8
  %11 = getelementptr inbounds %struct.Object, %struct.Object* %10, i32 0, i32 1
  %12 = bitcast %union.anon.0* %11 to i8**
  %13 = load i8*, i8** %12, align 8
  %14 = call i32 @strcmp(i8* %9, i8* %13)
  %15 = icmp ne i32 %14, 0
  %16 = xor i1 %15, true
  %17 = zext i1 %16 to i32
  %18 = sext i32 %17 to i64
  store i64 %18, i64* %5, align 8
  %19 = load i64, i64* %5, align 8
  %20 = call %struct.Object* @makeInt(i64 %19)
  ret %struct.Object* %20
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @neq_any(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  %5 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %4, align 8
  store %struct.Object* %1, %struct.Object** %5, align 8
  %6 = load %struct.Object*, %struct.Object** %4, align 8
  %7 = getelementptr inbounds %struct.Object, %struct.Object* %6, i32 0, i32 0
  %8 = bitcast %union.anon* %7 to i32*
  %9 = load i32, i32* %8, align 8
  %10 = icmp eq i32 %9, 1
  br i1 %10, label %11, label %21

; <label>:11                                      ; preds = %2
  %12 = load %struct.Object*, %struct.Object** %5, align 8
  %13 = getelementptr inbounds %struct.Object, %struct.Object* %12, i32 0, i32 0
  %14 = bitcast %union.anon* %13 to i32*
  %15 = load i32, i32* %14, align 8
  %16 = icmp eq i32 %15, 1
  br i1 %16, label %17, label %21

; <label>:17                                      ; preds = %11
  %18 = load %struct.Object*, %struct.Object** %4, align 8
  %19 = load %struct.Object*, %struct.Object** %5, align 8
  %20 = call %struct.Object* @neq_int(%struct.Object* %18, %struct.Object* %19)
  store %struct.Object* %20, %struct.Object** %3, align 8
  br label %40

; <label>:21                                      ; preds = %11, %2
  %22 = load %struct.Object*, %struct.Object** %4, align 8
  %23 = getelementptr inbounds %struct.Object, %struct.Object* %22, i32 0, i32 0
  %24 = bitcast %union.anon* %23 to i32*
  %25 = load i32, i32* %24, align 8
  %26 = icmp eq i32 %25, 2
  br i1 %26, label %27, label %37

; <label>:27                                      ; preds = %21
  %28 = load %struct.Object*, %struct.Object** %5, align 8
  %29 = getelementptr inbounds %struct.Object, %struct.Object* %28, i32 0, i32 0
  %30 = bitcast %union.anon* %29 to i32*
  %31 = load i32, i32* %30, align 8
  %32 = icmp eq i32 %31, 2
  br i1 %32, label %33, label %37

; <label>:33                                      ; preds = %27
  %34 = load %struct.Object*, %struct.Object** %4, align 8
  %35 = load %struct.Object*, %struct.Object** %5, align 8
  %36 = call %struct.Object* @neq_int(%struct.Object* %34, %struct.Object* %35)
  store %struct.Object* %36, %struct.Object** %3, align 8
  br label %40

; <label>:37                                      ; preds = %27, %21
  call void @error(i8* getelementptr inbounds ([54 x i8], [54 x i8]* @.str.1, i32 0, i32 0))
  br label %38

; <label>:38                                      ; preds = %37
  br label %39

; <label>:39                                      ; preds = %38
  store %struct.Object* null, %struct.Object** %3, align 8
  br label %40

; <label>:40                                      ; preds = %39, %33, %17
  %41 = load %struct.Object*, %struct.Object** %3, align 8
  ret %struct.Object* %41
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @sub_int(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 1
  %7 = bitcast %union.anon.0* %6 to i64*
  %8 = load i64, i64* %7, align 8
  %9 = load %struct.Object*, %struct.Object** %4, align 8
  %10 = getelementptr inbounds %struct.Object, %struct.Object* %9, i32 0, i32 1
  %11 = bitcast %union.anon.0* %10 to i64*
  %12 = load i64, i64* %11, align 8
  %13 = sub i64 %8, %12
  %14 = call %struct.Object* @makeInt(i64 %13)
  ret %struct.Object* %14
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @gt_int(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 1
  %7 = bitcast %union.anon.0* %6 to i64*
  %8 = load i64, i64* %7, align 8
  %9 = load %struct.Object*, %struct.Object** %4, align 8
  %10 = getelementptr inbounds %struct.Object, %struct.Object* %9, i32 0, i32 1
  %11 = bitcast %union.anon.0* %10 to i64*
  %12 = load i64, i64* %11, align 8
  %13 = icmp ugt i64 %8, %12
  %14 = zext i1 %13 to i32
  %15 = sext i32 %14 to i64
  %16 = call %struct.Object* @makeInt(i64 %15)
  ret %struct.Object* %16
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @geq_int(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 1
  %7 = bitcast %union.anon.0* %6 to i64*
  %8 = load i64, i64* %7, align 8
  %9 = load %struct.Object*, %struct.Object** %4, align 8
  %10 = getelementptr inbounds %struct.Object, %struct.Object* %9, i32 0, i32 1
  %11 = bitcast %union.anon.0* %10 to i64*
  %12 = load i64, i64* %11, align 8
  %13 = icmp uge i64 %8, %12
  %14 = zext i1 %13 to i32
  %15 = sext i32 %14 to i64
  %16 = call %struct.Object* @makeInt(i64 %15)
  ret %struct.Object* %16
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @lt_int(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 1
  %7 = bitcast %union.anon.0* %6 to i64*
  %8 = load i64, i64* %7, align 8
  %9 = load %struct.Object*, %struct.Object** %4, align 8
  %10 = getelementptr inbounds %struct.Object, %struct.Object* %9, i32 0, i32 1
  %11 = bitcast %union.anon.0* %10 to i64*
  %12 = load i64, i64* %11, align 8
  %13 = icmp ult i64 %8, %12
  %14 = zext i1 %13 to i32
  %15 = sext i32 %14 to i64
  %16 = call %struct.Object* @makeInt(i64 %15)
  ret %struct.Object* %16
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @leq_int(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 1
  %7 = bitcast %union.anon.0* %6 to i64*
  %8 = load i64, i64* %7, align 8
  %9 = load %struct.Object*, %struct.Object** %4, align 8
  %10 = getelementptr inbounds %struct.Object, %struct.Object* %9, i32 0, i32 1
  %11 = bitcast %union.anon.0* %10 to i64*
  %12 = load i64, i64* %11, align 8
  %13 = icmp ule i64 %8, %12
  %14 = zext i1 %13 to i32
  %15 = sext i32 %14 to i64
  %16 = call %struct.Object* @makeInt(i64 %15)
  ret %struct.Object* %16
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @div_int(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 1
  %7 = bitcast %union.anon.0* %6 to i64*
  %8 = load i64, i64* %7, align 8
  %9 = load %struct.Object*, %struct.Object** %4, align 8
  %10 = getelementptr inbounds %struct.Object, %struct.Object* %9, i32 0, i32 1
  %11 = bitcast %union.anon.0* %10 to i64*
  %12 = load i64, i64* %11, align 8
  %13 = udiv i64 %8, %12
  %14 = call %struct.Object* @makeInt(i64 %13)
  ret %struct.Object* %14
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @mul_int(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 1
  %7 = bitcast %union.anon.0* %6 to i64*
  %8 = load i64, i64* %7, align 8
  %9 = load %struct.Object*, %struct.Object** %4, align 8
  %10 = getelementptr inbounds %struct.Object, %struct.Object* %9, i32 0, i32 1
  %11 = bitcast %union.anon.0* %10 to i64*
  %12 = load i64, i64* %11, align 8
  %13 = mul i64 %8, %12
  %14 = call %struct.Object* @makeInt(i64 %13)
  ret %struct.Object* %14
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @and_int(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 1
  %7 = bitcast %union.anon.0* %6 to i64*
  %8 = load i64, i64* %7, align 8
  %9 = load %struct.Object*, %struct.Object** %4, align 8
  %10 = getelementptr inbounds %struct.Object, %struct.Object* %9, i32 0, i32 1
  %11 = bitcast %union.anon.0* %10 to i64*
  %12 = load i64, i64* %11, align 8
  %13 = and i64 %8, %12
  %14 = call %struct.Object* @makeInt(i64 %13)
  ret %struct.Object* %14
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @or_int(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 1
  %7 = bitcast %union.anon.0* %6 to i64*
  %8 = load i64, i64* %7, align 8
  %9 = load %struct.Object*, %struct.Object** %4, align 8
  %10 = getelementptr inbounds %struct.Object, %struct.Object* %9, i32 0, i32 1
  %11 = bitcast %union.anon.0* %10 to i64*
  %12 = load i64, i64* %11, align 8
  %13 = or i64 %8, %12
  %14 = call %struct.Object* @makeInt(i64 %13)
  ret %struct.Object* %14
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @sub_any(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 0
  %7 = bitcast %union.anon* %6 to i32*
  %8 = load i32, i32* %7, align 8
  %9 = icmp ne i32 %8, 1
  br i1 %9, label %16, label %10

; <label>:10                                      ; preds = %2
  %11 = load %struct.Object*, %struct.Object** %4, align 8
  %12 = getelementptr inbounds %struct.Object, %struct.Object* %11, i32 0, i32 0
  %13 = bitcast %union.anon* %12 to i32*
  %14 = load i32, i32* %13, align 8
  %15 = icmp ne i32 %14, 1
  br i1 %15, label %16, label %17

; <label>:16                                      ; preds = %10, %2
  call void @error(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i32 0, i32 0))
  br label %17

; <label>:17                                      ; preds = %16, %10
  %18 = load %struct.Object*, %struct.Object** %3, align 8
  %19 = load %struct.Object*, %struct.Object** %4, align 8
  %20 = call %struct.Object* @gt_int(%struct.Object* %18, %struct.Object* %19)
  ret %struct.Object* %20
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @gt_any(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 0
  %7 = bitcast %union.anon* %6 to i32*
  %8 = load i32, i32* %7, align 8
  %9 = icmp ne i32 %8, 1
  br i1 %9, label %16, label %10

; <label>:10                                      ; preds = %2
  %11 = load %struct.Object*, %struct.Object** %4, align 8
  %12 = getelementptr inbounds %struct.Object, %struct.Object* %11, i32 0, i32 0
  %13 = bitcast %union.anon* %12 to i32*
  %14 = load i32, i32* %13, align 8
  %15 = icmp ne i32 %14, 1
  br i1 %15, label %16, label %17

; <label>:16                                      ; preds = %10, %2
  call void @error(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i32 0, i32 0))
  br label %17

; <label>:17                                      ; preds = %16, %10
  %18 = load %struct.Object*, %struct.Object** %3, align 8
  %19 = load %struct.Object*, %struct.Object** %4, align 8
  %20 = call %struct.Object* @gt_int(%struct.Object* %18, %struct.Object* %19)
  ret %struct.Object* %20
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @geq_any(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 0
  %7 = bitcast %union.anon* %6 to i32*
  %8 = load i32, i32* %7, align 8
  %9 = icmp ne i32 %8, 1
  br i1 %9, label %16, label %10

; <label>:10                                      ; preds = %2
  %11 = load %struct.Object*, %struct.Object** %4, align 8
  %12 = getelementptr inbounds %struct.Object, %struct.Object* %11, i32 0, i32 0
  %13 = bitcast %union.anon* %12 to i32*
  %14 = load i32, i32* %13, align 8
  %15 = icmp ne i32 %14, 1
  br i1 %15, label %16, label %17

; <label>:16                                      ; preds = %10, %2
  call void @error(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i32 0, i32 0))
  br label %17

; <label>:17                                      ; preds = %16, %10
  %18 = load %struct.Object*, %struct.Object** %3, align 8
  %19 = load %struct.Object*, %struct.Object** %4, align 8
  %20 = call %struct.Object* @geq_int(%struct.Object* %18, %struct.Object* %19)
  ret %struct.Object* %20
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @lt_any(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 0
  %7 = bitcast %union.anon* %6 to i32*
  %8 = load i32, i32* %7, align 8
  %9 = icmp ne i32 %8, 1
  br i1 %9, label %16, label %10

; <label>:10                                      ; preds = %2
  %11 = load %struct.Object*, %struct.Object** %4, align 8
  %12 = getelementptr inbounds %struct.Object, %struct.Object* %11, i32 0, i32 0
  %13 = bitcast %union.anon* %12 to i32*
  %14 = load i32, i32* %13, align 8
  %15 = icmp ne i32 %14, 1
  br i1 %15, label %16, label %17

; <label>:16                                      ; preds = %10, %2
  call void @error(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i32 0, i32 0))
  br label %17

; <label>:17                                      ; preds = %16, %10
  %18 = load %struct.Object*, %struct.Object** %3, align 8
  %19 = load %struct.Object*, %struct.Object** %4, align 8
  %20 = call %struct.Object* @lt_int(%struct.Object* %18, %struct.Object* %19)
  ret %struct.Object* %20
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @leq_any(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 0
  %7 = bitcast %union.anon* %6 to i32*
  %8 = load i32, i32* %7, align 8
  %9 = icmp ne i32 %8, 1
  br i1 %9, label %16, label %10

; <label>:10                                      ; preds = %2
  %11 = load %struct.Object*, %struct.Object** %4, align 8
  %12 = getelementptr inbounds %struct.Object, %struct.Object* %11, i32 0, i32 0
  %13 = bitcast %union.anon* %12 to i32*
  %14 = load i32, i32* %13, align 8
  %15 = icmp ne i32 %14, 1
  br i1 %15, label %16, label %17

; <label>:16                                      ; preds = %10, %2
  call void @error(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i32 0, i32 0))
  br label %17

; <label>:17                                      ; preds = %16, %10
  %18 = load %struct.Object*, %struct.Object** %3, align 8
  %19 = load %struct.Object*, %struct.Object** %4, align 8
  %20 = call %struct.Object* @leq_int(%struct.Object* %18, %struct.Object* %19)
  ret %struct.Object* %20
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @div_any(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 0
  %7 = bitcast %union.anon* %6 to i32*
  %8 = load i32, i32* %7, align 8
  %9 = icmp ne i32 %8, 1
  br i1 %9, label %16, label %10

; <label>:10                                      ; preds = %2
  %11 = load %struct.Object*, %struct.Object** %4, align 8
  %12 = getelementptr inbounds %struct.Object, %struct.Object* %11, i32 0, i32 0
  %13 = bitcast %union.anon* %12 to i32*
  %14 = load i32, i32* %13, align 8
  %15 = icmp ne i32 %14, 1
  br i1 %15, label %16, label %17

; <label>:16                                      ; preds = %10, %2
  call void @error(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i32 0, i32 0))
  br label %17

; <label>:17                                      ; preds = %16, %10
  %18 = load %struct.Object*, %struct.Object** %3, align 8
  %19 = load %struct.Object*, %struct.Object** %4, align 8
  %20 = call %struct.Object* @div_int(%struct.Object* %18, %struct.Object* %19)
  ret %struct.Object* %20
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @mul_any(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 0
  %7 = bitcast %union.anon* %6 to i32*
  %8 = load i32, i32* %7, align 8
  %9 = icmp ne i32 %8, 1
  br i1 %9, label %16, label %10

; <label>:10                                      ; preds = %2
  %11 = load %struct.Object*, %struct.Object** %4, align 8
  %12 = getelementptr inbounds %struct.Object, %struct.Object* %11, i32 0, i32 0
  %13 = bitcast %union.anon* %12 to i32*
  %14 = load i32, i32* %13, align 8
  %15 = icmp ne i32 %14, 1
  br i1 %15, label %16, label %17

; <label>:16                                      ; preds = %10, %2
  call void @error(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i32 0, i32 0))
  br label %17

; <label>:17                                      ; preds = %16, %10
  %18 = load %struct.Object*, %struct.Object** %3, align 8
  %19 = load %struct.Object*, %struct.Object** %4, align 8
  %20 = call %struct.Object* @mul_int(%struct.Object* %18, %struct.Object* %19)
  ret %struct.Object* %20
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @and_any(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 0
  %7 = bitcast %union.anon* %6 to i32*
  %8 = load i32, i32* %7, align 8
  %9 = icmp ne i32 %8, 1
  br i1 %9, label %16, label %10

; <label>:10                                      ; preds = %2
  %11 = load %struct.Object*, %struct.Object** %4, align 8
  %12 = getelementptr inbounds %struct.Object, %struct.Object* %11, i32 0, i32 0
  %13 = bitcast %union.anon* %12 to i32*
  %14 = load i32, i32* %13, align 8
  %15 = icmp ne i32 %14, 1
  br i1 %15, label %16, label %17

; <label>:16                                      ; preds = %10, %2
  call void @error(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i32 0, i32 0))
  br label %17

; <label>:17                                      ; preds = %16, %10
  %18 = load %struct.Object*, %struct.Object** %3, align 8
  %19 = load %struct.Object*, %struct.Object** %4, align 8
  %20 = call %struct.Object* @and_int(%struct.Object* %18, %struct.Object* %19)
  ret %struct.Object* %20
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @or_any(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = getelementptr inbounds %struct.Object, %struct.Object* %5, i32 0, i32 0
  %7 = bitcast %union.anon* %6 to i32*
  %8 = load i32, i32* %7, align 8
  %9 = icmp ne i32 %8, 1
  br i1 %9, label %16, label %10

; <label>:10                                      ; preds = %2
  %11 = load %struct.Object*, %struct.Object** %4, align 8
  %12 = getelementptr inbounds %struct.Object, %struct.Object* %11, i32 0, i32 0
  %13 = bitcast %union.anon* %12 to i32*
  %14 = load i32, i32* %13, align 8
  %15 = icmp ne i32 %14, 1
  br i1 %15, label %16, label %17

; <label>:16                                      ; preds = %10, %2
  call void @error(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i32 0, i32 0))
  br label %17

; <label>:17                                      ; preds = %16, %10
  %18 = load %struct.Object*, %struct.Object** %3, align 8
  %19 = load %struct.Object*, %struct.Object** %4, align 8
  %20 = call %struct.Object* @or_int(%struct.Object* %18, %struct.Object* %19)
  ret %struct.Object* %20
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @cons_any(%struct.Object*, %struct.Object*) #0 {
  %3 = alloca %struct.Object*, align 8
  %4 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  store %struct.Object* %1, %struct.Object** %4, align 8
  %5 = load %struct.Object*, %struct.Object** %3, align 8
  %6 = load %struct.Object*, %struct.Object** %4, align 8
  %7 = call %struct.Object* @makeList(%struct.Object* %5, %struct.Object* %6)
  ret %struct.Object* %7
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @hd(%struct.Object*) #0 {
  %2 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %2, align 8
  %3 = load %struct.Object*, %struct.Object** %2, align 8
  %4 = getelementptr inbounds %struct.Object, %struct.Object* %3, i32 0, i32 0
  %5 = bitcast %union.anon* %4 to %struct.Object**
  %6 = load %struct.Object*, %struct.Object** %5, align 8
  ret %struct.Object* %6
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @tl(%struct.Object*) #0 {
  %2 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %2, align 8
  %3 = load %struct.Object*, %struct.Object** %2, align 8
  %4 = getelementptr inbounds %struct.Object, %struct.Object* %3, i32 0, i32 1
  %5 = bitcast %union.anon.0* %4 to %struct.Object**
  %6 = load %struct.Object*, %struct.Object** %5, align 8
  ret %struct.Object* %6
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @hd_any(%struct.Object*) #0 {
  %2 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %2, align 8
  %3 = load %struct.Object*, %struct.Object** %2, align 8
  %4 = getelementptr inbounds %struct.Object, %struct.Object* %3, i32 0, i32 0
  %5 = bitcast %union.anon* %4 to %struct.Object**
  %6 = load %struct.Object*, %struct.Object** %5, align 8
  %7 = ptrtoint %struct.Object* %6 to i64
  %8 = icmp ult i64 %7, 4
  br i1 %8, label %9, label %10

; <label>:9                                       ; preds = %1
  call void @error(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0))
  br label %10

; <label>:10                                      ; preds = %9, %1
  %11 = load %struct.Object*, %struct.Object** %2, align 8
  %12 = call %struct.Object* @hd(%struct.Object* %11)
  ret %struct.Object* %12
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @tl_any(%struct.Object*) #0 {
  %2 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %2, align 8
  %3 = load %struct.Object*, %struct.Object** %2, align 8
  %4 = getelementptr inbounds %struct.Object, %struct.Object* %3, i32 0, i32 0
  %5 = bitcast %union.anon* %4 to %struct.Object**
  %6 = load %struct.Object*, %struct.Object** %5, align 8
  %7 = ptrtoint %struct.Object* %6 to i64
  %8 = icmp ult i64 %7, 4
  br i1 %8, label %9, label %10

; <label>:9                                       ; preds = %1
  call void @error(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0))
  br label %10

; <label>:10                                      ; preds = %9, %1
  %11 = load %struct.Object*, %struct.Object** %2, align 8
  %12 = call %struct.Object* @tl(%struct.Object* %11)
  ret %struct.Object* %12
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @is_nil(%struct.Object*) #0 {
  %2 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %2, align 8
  %3 = load %struct.Object*, %struct.Object** %2, align 8
  %4 = getelementptr inbounds %struct.Object, %struct.Object* %3, i32 0, i32 0
  %5 = bitcast %union.anon* %4 to i32*
  %6 = load i32, i32* %5, align 8
  %7 = icmp eq i32 %6, 0
  %8 = zext i1 %7 to i32
  %9 = sext i32 %8 to i64
  %10 = call %struct.Object* @makeInt(i64 %9)
  ret %struct.Object* %10
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @print_int(%struct.Object*) #0 {
  %2 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %2, align 8
  %3 = load %struct.Object*, %struct.Object** %2, align 8
  %4 = getelementptr inbounds %struct.Object, %struct.Object* %3, i32 0, i32 1
  %5 = bitcast %union.anon.0* %4 to i64*
  %6 = load i64, i64* %5, align 8
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i32 0, i32 0), i64 %6)
  %8 = call %struct.Object* @makeInt(i64 0)
  ret %struct.Object* %8
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @print_str(%struct.Object*) #0 {
  %2 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %2, align 8
  %3 = load %struct.Object*, %struct.Object** %2, align 8
  %4 = getelementptr inbounds %struct.Object, %struct.Object* %3, i32 0, i32 1
  %5 = bitcast %union.anon.0* %4 to i8**
  %6 = load i8*, i8** %5, align 8
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i8* %6)
  %8 = call %struct.Object* @makeInt(i64 0)
  ret %struct.Object* %8
}

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @print_list(%struct.Object*) #0 {
  %2 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %2, align 8
  %3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0))
  %4 = load %struct.Object*, %struct.Object** %2, align 8
  %5 = icmp ne %struct.Object* %4, null
  br i1 %5, label %6, label %20

; <label>:6                                       ; preds = %1
  %7 = load %struct.Object*, %struct.Object** %2, align 8
  %8 = getelementptr inbounds %struct.Object, %struct.Object* %7, i32 0, i32 0
  %9 = bitcast %union.anon* %8 to %struct.Object**
  %10 = load %struct.Object*, %struct.Object** %9, align 8
  %11 = call %struct.Object* @print_any(%struct.Object* %10)
  %12 = bitcast %struct.Object* %11 to i8*
  call void @free(i8* %12)
  %13 = load %struct.Object*, %struct.Object** %2, align 8
  %14 = getelementptr inbounds %struct.Object, %struct.Object* %13, i32 0, i32 1
  %15 = bitcast %union.anon.0* %14 to %struct.Object**
  %16 = load %struct.Object*, %struct.Object** %15, align 8
  %17 = call %struct.Object* @print_list(%struct.Object* %16)
  %18 = bitcast %struct.Object* %17 to i8*
  call void @free(i8* %18)
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.6, i32 0, i32 0))
  br label %22

; <label>:20                                      ; preds = %1
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.7, i32 0, i32 0))
  br label %22

; <label>:22                                      ; preds = %20, %6
  %23 = call %struct.Object* @makeInt(i64 0)
  ret %struct.Object* %23
}

declare void @free(i8*) #1

; Function Attrs: nounwind ssp uwtable
define %struct.Object* @print_any(%struct.Object*) #0 {
  %2 = alloca %struct.Object*, align 8
  %3 = alloca %struct.Object*, align 8
  store %struct.Object* %0, %struct.Object** %3, align 8
  %4 = load %struct.Object*, %struct.Object** %3, align 8
  %5 = getelementptr inbounds %struct.Object, %struct.Object* %4, i32 0, i32 0
  %6 = bitcast %union.anon* %5 to i32*
  %7 = load i32, i32* %6, align 8
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %12

; <label>:9                                       ; preds = %1
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.8, i32 0, i32 0))
  %11 = call %struct.Object* @makeInt(i64 0)
  store %struct.Object* %11, %struct.Object** %2, align 8
  br label %42

; <label>:12                                      ; preds = %1
  %13 = load %struct.Object*, %struct.Object** %3, align 8
  %14 = getelementptr inbounds %struct.Object, %struct.Object* %13, i32 0, i32 0
  %15 = bitcast %union.anon* %14 to i32*
  %16 = load i32, i32* %15, align 8
  %17 = icmp eq i32 %16, 1
  br i1 %17, label %18, label %21

; <label>:18                                      ; preds = %12
  %19 = load %struct.Object*, %struct.Object** %3, align 8
  %20 = call %struct.Object* @print_int(%struct.Object* %19)
  store %struct.Object* %20, %struct.Object** %2, align 8
  br label %42

; <label>:21                                      ; preds = %12
  %22 = load %struct.Object*, %struct.Object** %3, align 8
  %23 = getelementptr inbounds %struct.Object, %struct.Object* %22, i32 0, i32 0
  %24 = bitcast %union.anon* %23 to i32*
  %25 = load i32, i32* %24, align 8
  %26 = icmp eq i32 %25, 2
  br i1 %26, label %27, label %30

; <label>:27                                      ; preds = %21
  %28 = load %struct.Object*, %struct.Object** %3, align 8
  %29 = call %struct.Object* @print_str(%struct.Object* %28)
  store %struct.Object* %29, %struct.Object** %2, align 8
  br label %42

; <label>:30                                      ; preds = %21
  %31 = load %struct.Object*, %struct.Object** %3, align 8
  %32 = getelementptr inbounds %struct.Object, %struct.Object* %31, i32 0, i32 0
  %33 = bitcast %union.anon* %32 to i32*
  %34 = load i32, i32* %33, align 8
  %35 = icmp eq i32 %34, 3
  br i1 %35, label %36, label %39

; <label>:36                                      ; preds = %30
  %37 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.9, i32 0, i32 0))
  %38 = call %struct.Object* @makeInt(i64 0)
  store %struct.Object* %38, %struct.Object** %2, align 8
  br label %42

; <label>:39                                      ; preds = %30
  %40 = load %struct.Object*, %struct.Object** %3, align 8
  %41 = call %struct.Object* @print_list(%struct.Object* %40)
  store %struct.Object* %41, %struct.Object** %2, align 8
  br label %42

; <label>:42                                      ; preds = %39, %36, %27, %18, %9
  %43 = load %struct.Object*, %struct.Object** %2, align 8
  ret %struct.Object* %43
}

; Function Attrs: nounwind ssp uwtable
define i32 @main() #0 {
  %1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.10, i32 0, i32 0))
  ret i32 0
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readnone }
attributes #5 = { noreturn }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"Apple LLVM version 8.0.0 (clang-800.0.42.1)"}
