var j = window.j = jQuery;
assign_slider_handlers(j('#content'));


function assign_slider_handlers (div) {

    div.find('.previous, .next')
        .unbind('click')
        .click( swipe_photo )
        .each( function(idx, el) {
            cache_div(el.href, true) } );
}

function cache_div (url, async) {
    if (cached_div(url))
        return cached_div(url);

    var div = photo_div(url, async);
    j('body').data(url, div);
    return div;
}

function cached_div (url) {
    var div = j('body').data(url) || false;
    return div;
}

function photo_div (url, async) {

    var html = j.ajax({
        url: url,
        async: async
    });

    //var id = '#p' + url.split('/').pop();
    var id = '#' + url.split('/').pop();
    var div = j(html.responseText).find(id) || false;

    return div;
}

function id_from_url(url) {
    return '#' + url.split('/').pop();
}

function swipe_photo (ev) {

    var url          = ev.target.href;
    var existing_div = j(ev.target).parents('.slide');
    var className    = ev.target.className;
    var title        = existing_div.find('.pagetitle').text();

    var replacement_div = cached_div(url) || cache_div(url, photo_div(url));

    if (!replacement_div)
        return false;

    existing_div.parent().append(replacement_div);
    assign_slider_handlers(existing_div);

    slide_element(existing_div, slide_direction(className), replacement_div);

    set_page_title(title);

    return false;
};

function slide_element (existing_el, direction, replacement_el) {
    // swap elements with slide effect

    existing_el.effect(
        'slide', { direction: direction.shift(), mode: 'hide' }, 150,
        function() {
            // replacement_el is hidden - reveal it
            replacement_el.effect( 'slide', { direction: direction.shift(), mode: 'show' }, 150, 
                function() { window.location.hash = '!' + replacement_el.attr('id'); }, 1000 );
        }
    );
}

function set_page_title (title) {
    j( "title" ).text(title);
}

function slide_direction (className) {
    return className == 'previous' ? [ 'right', 'left' ] : [ 'left', 'right' ];
}
