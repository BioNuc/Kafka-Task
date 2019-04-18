KafkaTask.require("KafkaTask.Homepage", function(){
  var that = {};
  
  var init = function(){
    initDomElements();
    render();
  };
  that.init = init;
  
  var page = null;
  var yesCheckbox = null;
  var noCheckbox = null;
  var submitTrigger = null;
  var initDomElements = function(){
    page = $('.js-page');
    yesCheckbox = page.find('.js-yesCheckbox');
    noCheckbox = page.find('.js-noCheckbox');
    submitTrigger = page.find('.js-submitTrigger');
  };
  
  var render = function(){
    yesCheckbox.click(function(){
      noCheckbox.prop('checked', false);
      toggleVoteCheckboxes('yes');
    });
    
    noCheckbox.click(function(){
      yesCheckbox.prop('checked', false);
    });
    
    submitTrigger.click(function(e){
      if (!voteSelected()){
        e.preventDefault();
        
        alert('You must choose either Yes or No for your vote');
      } 
    });
  };
  
  var voteSelected = function(){
    return (yesCheckbox.is(":checked") || noCheckbox.is(":checked"));
  };
  
  return that;
}());