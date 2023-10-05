(function ($) {
  "use strict";

  var viewMode = '';
  var isInitAOS = false;
  var TOTAL_HEIGHT_HEADER = 170;
  var BREAKPOINT_MOBILE = 991;
  var elMainHeader = $('.main-header');
  var elSectionContent = $('#content .section-content');
  var elNavBar = $('.main-navbar');
  var elMainWrapper = $('.main-wrapper');
  var sidebar = $('#sidebar');
  var btnSidebar = $('#sidebarCollapse');
  var btnMenuSections = $('.btn-menu-sections');

  var initAOS = function () {
    AOS.init();
    isInitAOS = true;
  }


  /******************************/
  /* BEHAVIOR FOR WINDOW RESIZE */
  /******************************/

  var setViewMode = function () {
    var windowWidth = $(window).width();
    if (windowWidth > BREAKPOINT_MOBILE) {
      viewMode = 'desktop';
      setTimeout(function() {
        elMainHeader.removeClass('hide-header');
        elSectionContent.removeClass('hide-header');
        elNavBar.removeClass('hide-header');
        elMainWrapper.removeClass('hide-header');
      }, 2000);
      initAOS();
    } else {
      viewMode = 'mobile';
      setTimeout(function() {
        elMainHeader.addClass('hide-header');
        elSectionContent.addClass('hide-header');
        elNavBar.addClass('hide-header');
        elMainWrapper.addClass('hide-header');
      }, 2000);
      initAOS();
    }
  };

  $(window).resize(function() {
    setViewMode();
    setNavBarLeftSpace();
  });
  setViewMode();


  /************************/
  /* BEHAVIOR FOR SIDEBAR */
  /************************/

  btnSidebar.on('click', function () {
    $('#sidebar').toggleClass('active');
  });

  var setNavBarLeftSpace = function () {
    if (viewMode === 'desktop') {
      if (sidebar.hasClass('active')) {
        elNavBar.removeClass('left-space');
      } else {
        elNavBar.addClass('left-space');
      }
    } else if (viewMode === 'mobile') {
      if (sidebar.hasClass('active')) {
        elNavBar.addClass('left-space');
      } else {
        elNavBar.removeClass('left-space');
      }
    }
  };

  btnSidebar.on('click', function() {
    setNavBarLeftSpace();
  });
  setNavBarLeftSpace();

  sidebar.on('click', 'a', function() {
    console.log('click sideBar!!!');
    var options = $('#sidebar .list-unstyled a');
    for (var i=0; i < options.length; i++){
      $(options[i]).removeClass('active');
      $(options[i]).parent().removeClass('active');
    }
    $(this).parent().addClass('active');
    if (viewMode === 'mobile') {
      var attrToggle = $(this).attr('data-toggle');
      if (attrToggle && attrToggle === 'tab') {
        btnSidebar.click();
      }
    }
  });


  /******************************************/
  /* BEHAVIOR FOR CLICK AND SCROLL SECTIONS */
  /******************************************/

  elNavBar.on('click', 'a', function(event) {
    var href = $(this).attr('href');
    var new_position = $(href).offset();
    new_position.top -= TOTAL_HEIGHT_HEADER;
    $('html, body').stop().animate({ scrollTop: new_position.top }, 500);
    btnMenuSections.click();

    var sections = $('#navbarSupportedContent .nav-link');
    for (var i=0; i < sections.length; i++){
      $(sections[i]).parent().removeClass('active');
    }
    $(this).parent().addClass('active');
    event.preventDefault();
  });


  /**********************/
  /* BEHAVIOR FOR MODAL */
  /**********************/

  var elModal = $('#initModal');
  var modalTitle = elModal.find('.modal-title');
  var modalText = elModal.find('.modal-text');
  var modalBtnCancel = elModal.find('.modal-btn-cancel');
  var modalBtnOk = elModal.find('.modal-btn-ok');

  modalTitle.html(modalData.title);
  modalText.html(modalData.text);
  modalBtnCancel.append(modalData.btnCancelText);

  if (modalData.btnOkText) {
    modalBtnOk.append('<a href="' + modalData.btnOkLink + '" target="_blank">' + modalData.btnOkText + '</a>');
  } else {
    modalBtnOk.remove();
  }

  if (modalData.show) {
    elModal.modal('show');
  }

})(jQuery);
