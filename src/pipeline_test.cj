package pipeline_test

import std.collection.ArrayList

// 测试 FilterStage
@Test
func testFilterStage() {
    let filter = FilterStage(5)
    @Expect(filter.process(10), Some(10))
    @Expect(filter.process(3), None)
    @Expect(filter.process(5), None)   // 不大于阈值，应为 None
    @Expect(filter.process(-1), None)
}

// 测试 MapStage
@Test
func testMapStage() {
    let mapper = MapStage(3)
    @Expect(mapper.process(2), 6)
    @Expect(mapper.process(0), 0)
    @Expect(mapper.process(-3), -9)
}

// 测试 SumStage
@Test
func testSumStage() {
    let sumStage = SumStage()
    @Expect(sumStage.process(10), 10)
    @Expect(sumStage.process(20), 30)
    @Expect(sumStage.process(-5), 25)
    @Expect(sumStage.getResult(), 25)
}

// 测试 SumStage reset
@Test
func testSumStageReset() {
    let sumStage = SumStage()
    sumStage.process(100)
    @Expect(sumStage.getResult(), 100)
    sumStage.reset()
    @Expect(sumStage.getResult(), 0)
}

// 测试 runPipeline 工具函数
@Test
func testRunPipeline() {
    let arr = [1, 6, 3, 8, 2, 10]
    let results = runPipeline(arr, 5, 2)
    @Expect(results.size, 3)
    @Expect(results[0], 12)   // 6*2
    @Expect(results[1], 16)   // 8*2
    @Expect(results[2], 20)   // 10*2
}

// 测试过滤-映射链式处理
@Test
func testFilterThenMap() {
    let filter = FilterStage(0)
    let mapper = MapStage(10)
    let results = ArrayList<Int64>()

    for (x in [-5, 0, 1, 10]) {
        match (filter.process(x)) {
            case Some(v) => results.add(mapper.process(v))
            case None => ()
        }
    }
    @Expect(results.size, 2)
    @Expect(results[0], 10)    // 1*10
    @Expect(results[1], 100)   // 10*10
}


