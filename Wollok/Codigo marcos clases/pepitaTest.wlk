// Tradicional: Hacer el test al final
// TDD (Test-driven development): Hacer el test primero

// En el archivo .wtest

describe "pepita" {

    // Expresivo ^^^
    test "pepita tiene una energía inicial de 100"
    {
        // Siempre se pone el valor esperado a la izquierda, y el valor real a
        // la derecha
        assert.equals(100, pepita.energia());
    }

}
