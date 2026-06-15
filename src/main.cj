package pipeline_test

main(): Int64 {
    println("=== Pipeline Demo ===")

    let arr = [1, 6, 3, 8, 2, 10]
    println("Input: ${arr}")

    let results = runPipeline(arr, 5, 2)
    println("Filter (>5) then Map (*2): ${results}")

    // 演示 SumStage
    let sumStage = SumStage()
    for (x in results) {
        sumStage.process(x)
    }
    println("Sum of results: ${sumStage.getResult()}")

    return 0
}
