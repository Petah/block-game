function src_json_file_read(_file) {
    if (!file_exists(_file)) {
        return undefined;
    }
    var _handle = file_text_open_read(_file);
    var _json_str = "";
    while (!file_text_eof(_handle)) {
        _json_str += file_text_read_string(_handle);
    }
    file_text_close(_handle);

    var _json_data = json_parse(_json_str);
    return _json_data;
}