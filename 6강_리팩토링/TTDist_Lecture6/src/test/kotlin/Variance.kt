import io.kotest.assertions.throwables.shouldThrow
import io.kotest.core.spec.style.FunSpec
import io.kotest.matchers.shouldBe

class Variance : FunSpec({
    test("no data - should throw IllegalStateException") {
        val exception = shouldThrow<IllegalStateException> {
            getVariance(emptyArray())
        }

        exception.message shouldBe "데이터가 입력되지 않았습니다."
    }

    test("only one data - should throw IllegalArgumentException") {
        val exception = shouldThrow<IllegalArgumentException> {
            getVariance(arrayOf("0.0"))
        }

        exception.message shouldBe "2개 이상의 데이터를 입력하세요."
    }

    test("1 2 3 4 5 6 - should return 3.5") {
        getVariance(arrayOf("1", "2", "3", "4", "5", "6")) shouldBe 3.5
    }
})