<template>
  <div id="calculator">
    <section class="calculator" id="calculator">
      <calculator-content></calculator-content>
    </section>
  </div>
</template>

<script>
import CalculatorContent from "./calculatorContent.vue";
export default {
  name: "calculator",
  components: {
    CalculatorContent
  }
};
</script>

<style>
@import url("https://fonts.googleapis.com/css?family=Pacifico");

.calculator {
  margin: 2.5rem auto;
  text-align: center;
}
.calculator {
  border: 0.8rem solid var(--lighter-green);
  width: 15rem;
  height: 20rem;
  background-color: var(--lighter-green);
  font-size: 0.7rem;
  -webkit-border-radius: 1rem;
  -moz-border-radius: 1rem;
  -ms-border-radius: 1rem;
  -o-border-radius: 1rem;
  border-radius: 1rem;
  -webkit-box-shadow: 1rem 1rem 0.5rem #ccc;
  box-shadow: 1rem 1rem 0.5rem #ccc;
}
</style>
