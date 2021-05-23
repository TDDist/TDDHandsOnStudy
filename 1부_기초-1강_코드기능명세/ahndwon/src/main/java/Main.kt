
fun main(args: Array<String>) {
    getVariance(args)
}

fun getVariance(args: Array<String>): Double {
    if (args.isEmpty()) {
        println("데이터가 입력되지 않았습니다.")
        throw IllegalStateException("데이터가 입력되지 않았습니다.")
    } else if (args.size == 1) {
        println("2개 이상의 데이터를 입력하세요.")
        throw IllegalArgumentException("2개 이상의 데이터를 입력하세요.")
    }


    val s = Array(args.size) { 0.toDouble() }
    repeat(args.size) { index ->
        s[index] = args[index].toDouble()
    }

    var sum = 0.0
    repeat(args.size) { index ->
        sum += s[index]
    }

    val mean: Double = sum / s.size
    var sumOfSquares = 0.0

    repeat(args.size) { i ->
        sumOfSquares += (s[i] - mean) * (s[i] - mean)
    }

    val variance = sumOfSquares / (s.size - 1)

    println("분산 : $variance")
    return variance
}