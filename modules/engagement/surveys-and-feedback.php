<?php
  $base_url = '/hrms/';
  $active = 'survey-and-feedback';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/hrms/public/styles/header.css">
    <link rel="stylesheet" href="/hrms/public/styles/sidebar.css">
    <link rel="stylesheet" href="/hrms/modules/engagement/styles/surveys-and-feedback.css">
    <link rel="icon" href="/hrms/public/img/k.png" type="image/png">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <title>Surveys and Feedback</title>
</head>
<body>

    <?php

      include_once('../../public/partials/header.php');

      include_once('../../public/partials/sidebar.php');
    ?>
  <aside>
    <div class="right-Panel">
      <div class="surveys-header">
        <strong>Surveys</strong>
        <div class="survesList">

        </div>
        <button  class="publishBtn">Publish</button>
        <button  class="ExportBtn">Export</button>
        <button class="deleteBtn">Delete</button>
        <button class="newSurveyBtn">New Survey</button>
      </div>
    </div>

    <div class="center-Panel">
      <strong class="survey-Title">Random Survey</strong>
      <div class="survey-Status">Draft</div>
      <div class="survey-Type">Anonymous</div>
      <div class="survey-Description">AHH SURVEY</div>

      <div class="questions-Container">
        <div class="questions-lists"></div>
        <input type="text" class="survey-Questions" placeholder="Add your question here">
        <select class="question-Type">
          <option value="multiple-choice">Multiple Choice</option>
          <option value="text">Text</option>
          <option value="rating">Rating</option>
        </select>
        <button class="add-questionBtn">Add</button>
          <button class="previewBtn">Preview</button>
          <button class="save-questionsBtn">Save</button>
    </div>

    <div class="participation-panel">
      <Strong>Participation</Strong>
      <small>Responses</small>
      <div class="stats">
        <div class="number-of-responses">0</div>
        <canvas class="response-bar"></canvas>
      </div>
    </div>
    <div class="feedback-panel">
      <Strong>Recent Feedback</Strong>
      <div class="feedback-lists">SAMPLE</div>
    </div>
  </aside>
     

</body>
</html>