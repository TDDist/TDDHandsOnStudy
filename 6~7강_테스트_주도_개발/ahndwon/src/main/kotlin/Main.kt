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


    val source = parseArguments(args)
    val mean = calculateMean(source)
    val sumOfSquares = newMethod(source, mean)
    val variance = sumOfSquares / (source.size - 1)
    println("분산 : $variance")
    return variance
}

private fun parseArguments(args: Array<String>): Array<Double> = args.map { it.toDouble() }.toTypedArray()

fun newMethod(source: Array<Double>, mean: Double): Double = source.map { it - mean }.sumOf { it * it }

fun calculateMean(source: Array<Double>): Double = source.average()