function src_json_file_write(_file, _json_data) {
    var _stringified_json = json_stringify(_json_data);
    var _handle = file_text_open_write(_file);
    file_text_write_string(_handle, _stringified_json);
    file_text_close(_handle);
}
