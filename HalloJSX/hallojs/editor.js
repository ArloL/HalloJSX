$(function() {
    var content = jQuery('#content');
        content.bind('hallomodified', function(event, data) {
        console.log('hallomodified');
        MyApp.save_(data.content);
    });
    content.hallo({
        toolbar: 'halloToolbarFixed',
        plugins: {
            'halloformat': {},
            'halloheadings': {},
            'hallojustify': {},
            'halloreundo': {},
            'hallolink': {}
        }
    });
});
