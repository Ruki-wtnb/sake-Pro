<style>
	.wrapper {width: 600px; margin: 20px auto; }
	ul.tabs {float: left; width: 200px; }
</style>

<div class="wrapper">

    <ul class="tabs">
        <li><a href="#gallery">Gallery</a></li>
        <li><a href="#submit">Submit</a></li>
        <li><a href="#resources">Resources</a></li>
    </ul>

    <div id="gallery" class="tab_content">
        <h2> Gallery</h2>
    </div>
    <div id="submit" class="tab_content">
        <h2> Submit</h2>
    </div>
    <div id="resources" class="tab_content">
        <h2> Resources</h2>
    </div>

</div>

<!-- jQuery -->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.js"></script>
<!-- Tabs -->
<!-- <script type="text/javascript" src="tabs.js"></script> -->
<script type="text/javascript">
  $(document).ready(function() {
    //Default Action
    $(".tab_content").hide(); //Hide all content
    $("ul.tabs li:first").addClass("active").show(); //Activate first tab
    $(".tab_content:first").show(); //Show first tab content

    //On Click Event
    $("ul.tabs li").click(function() {
      $("ul.tabs li").removeClass("active"); //Remove any "active" class
      $(this).addClass("active"); //Add "active" class to selected tab
      $(".tab_content").hide(); //Hide all tab content
      var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
      $(activeTab).fadeIn(); //Fade in the active content
      return false;
    });
  });
</script>