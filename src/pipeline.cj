package pipeline_test

import std.collection.ArrayList

// 流水线阶段接口
interface Stage<T, R> {
    func process(input: T): R
}

// 整数过滤阶段：保留大于阈值的数
class FilterStage <: Stage<Int64, Option<Int64>> {
    private var threshold: Int64

    public init(threshold: Int64) {
        this.threshold = threshold
    }

    public func process(input: Int64): Option<Int64> {
        if (input > threshold) {
            return Some(input)
        }
        return None
    }
}

// 整数映射阶段：乘以系数
class MapStage <: Stage<Int64, Int64> {
    private var factor: Int64

    public init(factor: Int64) {
        this.factor = factor
    }

    public func process(input: Int64): Int64 {
        return input * factor
    }
}

// 整数累加阶段
class SumStage <: Stage<Int64, Int64> {
    private var sum: Int64 = 0

    public func process(input: Int64): Int64 {
        sum += input
        return sum
    }

    public func getResult(): Int64 {
        return sum
    }

    public func reset() {
        sum = 0
    }
}

// 工具函数：对数组应用流水线
public func runPipeline(arr: Array<Int64>, threshold: Int64, factor: Int64): ArrayList<Int64> {
    let filter = FilterStage(threshold)
    let mapper = MapStage(factor)
    let results = ArrayList<Int64>()

    for (x in arr) {
        let filtered = filter.process(x)
        match (filtered) {
            case Some(v) =>
                let mapped = mapper.process(v)
                results.add(mapped)
            case None => ()
        }
    }
    return results
}
