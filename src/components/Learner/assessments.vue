<template>
  <div>
    <b-container fluid>
      <b-row class="mb-3">
        <b-col class="bg-white p-3 text-left">
          <h5>Assessments</h5>
        </b-col>
      </b-row>
      <b-row>
        <b-col sm="4">
          <div
            class="
              shadow
              bg-white
              rounded
              p-3
              position-relative
              text-left
              cursor-pointer
            "
            @click="$router.push('/learner/assessment/assignment')"
          >
            <b-badge class="badge" variant="danger">4</b-badge>
            <b-img
              :src="require('@/assets/images/ass3.png')"
              fluid-grow
              alt="assignments"
              class="mb-3"
            ></b-img>
            <div class="font-weight-bold fs15">Assignment</div>
            <p class="fs15 text-muted">View all assignments here</p>
          </div>
        </b-col>
        <b-col sm="4">
          <div
            class="
              shadow
              bg-white
              rounded
              p-3
              position-relative
              text-left
              cursor-pointer
            "
            @click="$router.push('/learner/assessment/quiz')"
          >
            <b-badge class="badge" variant="danger">4</b-badge>
            <b-img
              :src="require('@/assets/images/ass2.png')"
              alt="quiz"
              fluid-grow
              class="mb-3"
            ></b-img>
            <div class="font-weight-bold fs15">Quiz</div>
            <p class="fs15 text-muted">View all quizzes here</p>
          </div>
        </b-col>
        <b-col sm="4">
          <div
            class="
              shadow
              bg-white
              rounded
              p-3
              position-relative
              text-left
              cursor-pointer
            "
            @click="$router.push('/learner/assessment/test')"
          >
            <b-badge class="badge" variant="danger">4</b-badge>
            <b-img
              :src="require('@/assets/images/ass1.png')"
              alt="test"
              fluid-grow
              class="mb-3"
            ></b-img>
            <div class="font-weight-bold fs15">Test</div>
            <p class="fs15 text-muted">View all tests here</p>
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
export default {};
</script>
<style scoped>
.badge {
  position: absolute;
  top: 13px;
  right: 13px;
}
</style>
