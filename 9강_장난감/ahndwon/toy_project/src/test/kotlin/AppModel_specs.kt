import io.kotest.core.spec.style.AnnotationSpec
import io.kotest.matchers.shouldBe
import io.kotest.matchers.string.shouldContain
import io.kotest.matchers.string.shouldEndWith
import io.kotest.matchers.string.shouldStartWith

class AppModel_specs : AnnotationSpec() {
    @Test
    fun sut_is_incompleted_when_it_is_initialized() {
        val sut = AppModel(PositiveIntegerGeneratorStub(50))
        val actual = sut.isCompleted()
        actual shouldBe false
    }

    @Test
    fun sut_correctly_prints_select_mode_message() {
        val sut = AppModel(PositiveIntegerGeneratorStub(50))
        val actual = sut.flushOutput()

        actual shouldBe "1: Single player game\n2: Multiplayer game\n3: Exit\nEnter selection: "
    }

    @Test
    fun sut_correctly_exits() {
        val sut = AppModel(PositiveIntegerGeneratorStub(50))
        sut.processInput("3")
        val actual = sut.isCompleted()

        actual shouldBe true
    }

    @Test
    fun sut_correctly_prints_single_player_game_start_message() {
        val sut = AppModel(PositiveIntegerGeneratorStub(50))
        sut.flushOutput()
        sut.processInput("1")
        val actual = sut.flushOutput()

        actual shouldBe "Single player game\nI'm thinking of a number between 1 and 100.\nEnter your guess: "
    }

    @Test
    fun sut_correctly_prints_too_low_message_in_single_player_game() {
        listOf(
            "50" to "40",
            "30" to "29",
            "89" to "9"
        ).forEach { (answer, guess) ->
            val sut = AppModel(PositiveIntegerGeneratorStub(answer.toInt()))
            sut.processInput("1")
            sut.flushOutput()
            sut.processInput(guess)

            val actual = sut.flushOutput()
            actual shouldBe "Your guess is too low.\nEnter your guess: "
        }
    }

    @Test
    fun sut_correctly_prints_too_high_message_in_single_player_game() {
        listOf(
            "50" to "60",
            "80" to "81"
        ).forEach { (answer, guess) ->
            val sut = AppModel(PositiveIntegerGeneratorStub(answer.toInt()))
            sut.processInput("1")
            sut.flushOutput()
            sut.processInput(guess)

            val actual = sut.flushOutput()
            actual shouldBe "Your guess is too high.\nEnter your guess: "
        }
    }

    @Test
    fun sut_correctly_prints_correct_message_in_single_player_game() {
        listOf(
            1, 3, 10, 100
        ).forEach { answer ->
            val sut = AppModel(PositiveIntegerGeneratorStub(answer))
            sut.processInput("1")
            sut.flushOutput()
            sut.processInput(answer.toString())

            val actual = sut.flushOutput()
            actual shouldStartWith "Correct! "
        }
    }

    @Test
    fun sut_correctly_prints_guess_count_if_single_player_game_finished() {
        listOf(
            1, 3, 10, 100
        ).forEach { fails ->
            val sut = AppModel(PositiveIntegerGeneratorStub(50))
            sut.processInput("1")
            repeat(fails) {
                sut.processInput("30")
            }
//            sut.flushOutput()
            sut.processInput("50")

            val actual = sut.flushOutput()
            actual shouldContain "${fails + 1} guesses.\n"
        }
    }

    @Test
    fun sut_correctly_prints_one_guess_if_single_player_game_finished() {
        val sut = AppModel(PositiveIntegerGeneratorStub(50))
        sut.processInput("1")
        sut.flushOutput()
        sut.processInput("50")

        val actual = sut.flushOutput()
        actual shouldContain "1 guess.\n"
    }

    @Test
    fun sut_prints_select_mode_message_if_single_player_game_finished() {
        val sut = AppModel(PositiveIntegerGeneratorStub(50))
        sut.processInput("1")
        sut.flushOutput()
        sut.processInput("50")

        val actual = sut.flushOutput()
        actual shouldEndWith "1: Single player game\n2: Multiplayer game\n3: Exit\nEnter selection: "
    }

    @Test
    fun sut_returns_to_mode_selection_if_single_player_game_finished() {
        val sut = AppModel(PositiveIntegerGeneratorStub(50))
        sut.processInput("1")
        sut.processInput("50")
        sut.processInput("3")

        val actual = sut.isCompleted()
        actual shouldBe true
    }

    @Test
    fun sut_generates_answer_for_each_game() {
        val answers = "100, 10, 1".split(",").map(String::trim).map(Integer::parseInt).toIntArray()
        answers.forEach { answer ->
            val sut = AppModel(PositiveIntegerGeneratorStub(answer))
            sut.processInput("1")
            sut.flushOutput()
            sut.processInput(answer.toString())

            val actual = sut.flushOutput()
            actual shouldStartWith "Correct! "
        }
    }

    @Test
    fun sut_correctly_prints_multiplayer_game_setup_message() {
        val sut = AppModel(PositiveIntegerGeneratorStub(50))
        sut.flushOutput()
        sut.processInput("2")

        val actual = sut.flushOutput()
        actual shouldStartWith "Multiplayer game\nEnter player names separated with commas: "
    }

    @Test
    fun sut_correctly_prints_multiplayer_game_start_message() {
        val sut = AppModel(PositiveIntegerGeneratorStub(50))
        sut.processInput("2")
        sut.flushOutput()
        sut.processInput("Foo, Bar")

        val actual = sut.flushOutput()
        actual shouldStartWith "I'm thinking of a number between 1 and 100.\n"
    }

    @Test
    fun sut_correctly_prompts_first_player_name() {
        listOf(
            "Foo, Bar, Baz",
            "Bar, Baz, Foo",
            "Baz, Foo, Bar",
        ).map {
            it.split(",").map(String::trim)
        }.map {
            Triple(it[0], it[1], it[2])
        }.forEach { (player1, player2, player3) ->
            val sut = AppModel(PositiveIntegerGeneratorStub(50))
            sut.processInput("2")
            sut.flushOutput()
            sut.processInput("$player1, $player2, $player3")

            val actual = sut.flushOutput()
            actual shouldEndWith "Enter $player1's guess: "
        }
    }

    @Test
    fun sut_correctly_prompts_second_player_name() {
        listOf(
            "Foo, Bar, Baz",
            "Bar, Baz, Foo",
            "Baz, Foo, Bar",
        ).map {
            it.split(",").map(String::trim)
        }.map {
            Triple(it[0], it[1], it[2])
        }.forEach { (player1, player2, player3) ->
            val sut = AppModel(PositiveIntegerGeneratorStub(50))
            sut.processInput("2")
            sut.processInput("$player1, $player2, $player3")
            sut.flushOutput()
            sut.processInput("10")

            val actual = sut.flushOutput()
            actual shouldEndWith "Enter $player2's guess: "
        }
    }

    @Test
    fun sut_correctly_prompts_third_player_name() {
        listOf(
            "Foo, Bar, Baz",
            "Bar, Baz, Foo",
            "Baz, Foo, Bar",
        ).map {
            it.split(",").map(String::trim)
        }.map {
            Triple(it[0], it[1], it[2])
        }.forEach { (player1, player2, player3) ->
            val sut = AppModel(PositiveIntegerGeneratorStub(50))
            sut.processInput("2")
            sut.processInput("$player1, $player2, $player3")
            sut.processInput("90")
            sut.flushOutput()
            sut.processInput("90")

            val actual = sut.flushOutput()
            actual shouldEndWith "Enter $player3's guess: "
        }
    }

    @Test
    fun sut_correctly_prints_too_low_message_in_multiplayer_game() {
        listOf(
            "50, 40, 1, Foo",
            "30, 29, 2, Bar",
        ).map {
            it.split(",").map(String::trim)
        }.map {
            data class Quad<out A, out B, out C, out D>(
                val first: A,
                val second: B,
                val third: C,
                val fourth: D
            )
            Quad(it[0].toInt(), it[1].toInt(), it[2].toInt(), it[3])
        }.forEach { (answer, guess, fails, lastPlayer) ->
            val sut = AppModel(PositiveIntegerGeneratorStub(answer))
            sut.processInput("2")
            sut.processInput("Foo, Bar, Baz")
            repeat(fails - 1) {
                sut.processInput(guess.toString())
            }

            sut.flushOutput()
            sut.processInput(guess.toString())

            val actual = sut.flushOutput()
            actual shouldStartWith "$lastPlayer's guess is too low.\n"
        }
    }

    @Test
    fun sut_correctly_prints_too_high_message_in_multiplayer_game() {
        listOf(
            "50, 60, 1, Foo",
            "9, 81, 2, Bar",
        ).map {
            it.split(",").map(String::trim)
        }.map {
            data class Quad<out A, out B, out C, out D>(
                val first: A,
                val second: B,
                val third: C,
                val fourth: D
            )
            Quad(it[0].toInt(), it[1].toInt(), it[2].toInt(), it[3])
        }.forEach { (answer, guess, fails, lastPlayer) ->
            val sut = AppModel(PositiveIntegerGeneratorStub(answer))
            sut.processInput("2")
            sut.processInput("Foo, Bar, Baz")
            repeat(fails - 1) {
                sut.processInput(guess.toString())
            }

            sut.flushOutput()
            sut.processInput(guess.toString())

            val actual = sut.flushOutput()
            actual shouldStartWith "$lastPlayer's guess is too high.\n"
        }
    }

    @Test
    fun sut_correctly_prints_correct_message_in_multiplayer_game() {
        listOf(
            1, 10, 100
        ).forEach { answer ->
            val sut = AppModel(PositiveIntegerGeneratorStub(answer))
            sut.processInput("2")
            sut.processInput("Foo, Bar, Baz")
            sut.flushOutput()

            sut.processInput(answer.toString())

            val actual = sut.flushOutput()
            actual shouldStartWith "Correct! "
        }
    }

    @Test
    fun sut_correctly_prints_winner_if_multiplayer_game_finished() {
        listOf(
            "0" to "Foo",
            "1" to "Bar",
            "2" to "Baz",
            "99" to "Foo",
            "100" to "Bar",
        ).forEach { (fails, winner) ->
            val sut = AppModel(PositiveIntegerGeneratorStub(50))
            sut.processInput("2")
            sut.processInput("Foo, Bar, Baz")
            repeat(fails.toInt()) {
                sut.processInput("30")
            }
            sut.flushOutput()
            sut.processInput("50")

            val actual = sut.flushOutput()
            actual shouldContain "$winner wins.\n"
        }
    }

    @Test
    fun sut_prints_select_mode_message_if_multiplayer_game_finished() {
        val sut = AppModel(PositiveIntegerGeneratorStub(50))
        sut.processInput("2")
        sut.processInput("Foo, Bar, Baz")
        sut.flushOutput()
        sut.processInput("50")

        val actual = sut.flushOutput()
        actual shouldEndWith AppModel.SELECT_MODE_MESSAGE
    }

    @Test
    fun sut_returns_to_mode_selection_if_multiplayer_game_finished() {
        val sut = AppModel(PositiveIntegerGeneratorStub(50))
        sut.processInput("2")
        sut.processInput("Foo, Bar, Baz")
        sut.processInput("20")
        sut.processInput("50")
        sut.processInput("3")

        val actual = sut.isCompleted()
        actual shouldBe true
    }

}

