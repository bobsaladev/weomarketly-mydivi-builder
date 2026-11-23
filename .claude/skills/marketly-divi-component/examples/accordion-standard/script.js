(function ($) {
  function toggleItem($title) {
    var $item = $title.closest(".accordion-standard-item");
    var $root = $title.closest(".accordion-standard");
    var $panel = $item.find(".acc-content");

    $root.find(".acc-content").not($panel).slideUp();

    if ($title.hasClass("active")) {
      $title.removeClass("active").attr("aria-expanded", "false");
    } else {
      $root.find(".accordion-title.active").removeClass("active").attr("aria-expanded", "false");
      $title.addClass("active").attr("aria-expanded", "true");
    }

    $panel.stop(false, true).slideToggle();
  }

  $(document).on("click.accordionStandard", ".accordion-standard .accordion-title", function (event) {
    event.preventDefault();
    toggleItem($(this));
  });

  $(document).on("keydown.accordionStandard", ".accordion-standard .accordion-title", function (event) {
    if (event.key !== "Enter" && event.key !== " ") {
      return;
    }
    event.preventDefault();
    toggleItem($(this));
  });
})(jQuery);
