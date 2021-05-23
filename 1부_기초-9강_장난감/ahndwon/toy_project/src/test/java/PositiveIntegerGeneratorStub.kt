class PositiveIntegerGeneratorStub(vararg val numbers : Int) : PositiveIntegerGenerator {
    private var index = 0
    override fun generateLessThanOrEqualToHundred(): Int {
        index = index++ % numbers.size
        return numbers[index]
    }
}
