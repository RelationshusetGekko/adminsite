//= require codemirror
//= require codemirror/modes/ruby
//= require codemirror/modes/haml
//= require codemirror/modes/xml
//= require codemirror/modes/htmlembedded
//= require codemirror/modes/htmlmixed
//= require codemirror/modes/javascript
//= require codemirror/modes/yaml
//= require codemirror/addons/dialog/dialog
//= require codemirror/addons/edit/closebrackets
//= require codemirror/addons/edit/closetag
//= require codemirror/addons/edit/matchbrackets
//= require codemirror/addons/edit/matchtags
//= require codemirror/addons/edit/trailingspace

class window.B56Admin

B56Admin.initCodeEditor = ->
  $("textarea.code.html").each ->
    CodeMirror.fromTextArea $(this)[0],
      mode: "text/html"
      autoCloseTags: true
      lineNumbers: true
    return

  $("textarea.code.ruby").each ->
    CodeMirror.fromTextArea $(this)[0],
      mode: "ruby"
      lineNumbers: true
    return

  $("textarea.code.js").each ->
    CodeMirror.fromTextArea $(this)[0],
      mode: "text/javascript"
      matchBrackets: true
      autoCloseBrackets: true
      lineNumbers: true
    return

$(document).ready ->
  B56Admin.initCodeEditor()
