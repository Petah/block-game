function log_debug() {
    var _message = argument[0];
    var _arguments = [];
    for (var _i = 1; _i < argument_count; _i++) {
        array_push(_arguments, argument[_i]);
    }
    show_debug_message_ext(_message, _arguments);
}

function log_info() {
    var _message = argument[0];
    var _arguments = [];
    for (var _i = 1; _i < argument_count; _i++) {
        array_push(_arguments, argument[_i]);
    }
    show_debug_message_ext(_message, _arguments);
}
