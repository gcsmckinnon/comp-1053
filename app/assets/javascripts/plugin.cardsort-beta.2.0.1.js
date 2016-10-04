console.log("Plugin Loaded");
function CardSort ( options ) {
  self = this;
  self.options = options || {};
  self.init();
}

CardSort.prototype.init = function () {
  console.log("Initializing");

  // get the container that will hold the Card Sort Utility
  var container = self.options.container || 'body';
  $(container).append($('<div />', {id: 'cs-actions'}));
  $(container).append($('<div />', {id: 'cardsort-container'}));
  self.container = $('#cardsort-container');
  self.submitButton = $(self.options.submitButton) || $('#submit-button');
  self.resultInput = $(self.options.resultInput) || $('#result');

  // set the existing cards
  var cards = self.options.cards || [];

  // create the cards
  $(cards).each(function(index, cardDeets){
    var clone = $('<button />', {type: 'button', class: 'cs-clone'}).append($('<i />', {class: 'fa fa-clone'}));
    clone.css({background: 'transparent', outline: 0, border: 'none'})
    var card = $('<div />', {class: 'cs-card panel panel-default'});
    clone.bind('click', self.clone);
    card.append(cardDeets.label);
    card.append(clone);
    card.css({display: 'inline-block', margin: '0.5em', padding: '0.5em', cursor: 'pointer'});
    card.bind('click', self.select);
    card.appendTo(self.container);
  });

  // add group create button
  var acgButton = $('<button />', {'type': 'button', 'class': 'cs-addCreateGroup btn btn-default', 'title': 'Create new group.'}).append($('<i />', {'class': 'fa fa-plus'}));
  acgButton.append('&nbsp;Create Group');
  acgButton.bind('click', self.createGroup);
  acgButton.css({outline: 0});
  $('#cs-actions').prepend(acgButton);
};

CardSort.prototype.createGroup = function () {
  var group = $('<div />', {'class': 'cs-group panel panel-default'});
  var groupHeader = $('<div />', {'class': 'cs-groupHeader panel-heading'});
  var groupTitle = $('<h3 />', {'class': 'cs-groupTitle panel-title', 'contentEditable': true}).text('Edit Me');
  var groupRemove = $('<button />').append($('<i />', {class: 'fa fa-remove'})).css({background: 'none', outline: 0, border: 'none'});
  var groupSelect = $('<button />').append($('<i />', {class: 'fa fa-check'})).css({background: 'none', outline: 0, border: 'none'});
  var groupBody = $('<div />', {'class': 'cs-groupBody panel-body'});
  groupBody.bind('click', self.move);
  groupSelect.bind('click', self.select);
  groupRemove.bind('click', self.remove);
  groupHeader.append(groupTitle);
  groupHeader.append(groupRemove);
  groupHeader.append(groupSelect);
  group.append(groupHeader);
  group.append(groupBody);
  self.container.append(group);
};

CardSort.prototype.clone = function (e) {
  $(this).closest('.cs-card, .cs-group').toggleClass('cs-cloned');
  $(this).closest('.cs-card', '.cs-group').removeClass('cs-selected');
  e.stopPropagation();
};

CardSort.prototype.select = function (e) {
  $(this).closest('.cs-card, .cs-group').toggleClass('cs-selected');
  $(this).closest('.cs-card', '.cs-group').removeClass('cs-cloned');
  e.stopPropagation();
};

CardSort.prototype.remove = function (e) {
  // if group
  if($(this).closest('.cs-card, .cs-group').hasClass('cs-group')) {
    console.log('Is Group');
    // transfer child groups to container
    $(this).closest('.cs-group').find('.cs-groupBody').find('.cs-group').appendTo(self.container);
    // remove the child cards remove button
    $(this).closest('.cs-group').find('.cs-groupBody').find('.cs-card').find('button .fa-remove').remove();
    // kill the Clones
    $(this).closest('.cs-group').find('.cs-groupBody').find('.isClone').remove();
    // transfer child cards to container
    $(this).closest('.cs-group').find('.cs-groupBody').find('.cs-card').prependTo(self.container);
    // remove group
    $(this).closest('.cs-group').remove();
  }

  // if card
  if($(this).closest('.cs-card, .cs-group').hasClass('cs-card')) {
    console.log('Is Card');
    // if it's a clone, remove it
    if($(this).closest('.cs-card').hasClass('isClone')) {
      console.log('Is Clone');
      $(this).closest('.cs-card').remove();
    } else {
      // otherwise remove the remove button
      $(this).closest('.cs-card').find('button .fa-remove').remove();
      // append it to the container
      $(this).closest('.cs-card').prependTo(self.container);
    }
  }

  // check done will reassign the values
  self.checkDone();
  e.stopPropagation();
};

CardSort.prototype.move = function (e) {
  destination = this;
  var selected = $('.cs-selected');
  var cloned = $('.cs-cloned');
  selected.toggleClass('cs-selected');
  cloned.toggleClass('cs-cloned');

  $(selected).each(function(index, s) {
    var selectedText = $(s).text();
    var destinationText = $(destination).find('.cs-card:contains('+selectedText+')').text();
    if(selectedText == destinationText) {
      return;
    }
    if($(s).hasClass('cs-card') && $(s).find('button .fa-remove').length == 0) {
      var cardRemove = $('<button />').append($('<i />', {class: 'fa fa-remove'})).css({background: 'none', outline: 0, border: 'none'});
      cardRemove.bind('click', self.remove);
      $(s).append(cardRemove);
    }
    if(!$.contains(s, destination)) $(s).appendTo($(destination));
  });

  $(cloned).each(function(index, c) {
    var clonedText = $(c).text();
    var destinationText = $(destination).find('.cs-card:contains('+clonedText+')').text();
    if(clonedText == destinationText) {
      return;
    }
    if($(c).hasClass('cs-card') && $(c).find('button .fa-remove').length == 0) {
      var cardRemove = $('<button />').append($('<i />', {class: 'fa fa-remove'})).css({background: 'none', outline: 0, border: 'none'});
    }
    $(c).clone().addClass('isClone').append(cardRemove).bind('click', self.remove).appendTo($(destination));
  });
  self.checkDone();
  e.stopPropagation();
};

CardSort.prototype.checkDone = function () {
  console.log('Checking done.');
  if(self.container.find('> .cs-card').length == 0) {
    var results = self.getResults();
    $('#result').val(JSON.stringify(results));
    $('#create-card-sort').prop('disabled', false);
    $('#create-card-sort').click(function () {
      $('form').submit();
    });
  }
};

CardSort.prototype.getResults = function () {
  function walkit (item, tree) {
    // look for the item children
    var children = $(item).children();

    // assign the tree, or begin a new one
    var tree = tree || {};

    // iterate though each child
    $(children).each(function () {
      if($(this).hasClass('cs-group')) {
        // if cs-group item
        console.log('is a group');
        // get the label
        console.log($(this));
        var label = $(this).find('> .cs-groupHeader > .cs-groupTitle').text();
        // use the label of the current group item and rewalk to the group
        tree[label] = walkit($(this).children('.cs-groupBody'), tree[label]);
      } else if($(this).hasClass('cs-card')) {
        // if cs-card item
        console.log('is a card');
        // use the existing cards array, or create a new one
        tree['cards'] = tree['cards'] || [];
        // push the card to the array
        tree['cards'].push($(this).text());
      }
    });

    return tree;
  }

  return walkit(self.container);
};