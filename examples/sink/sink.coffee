{ready, model, view} = require('derby').createApp module, exports

view.make 'Head', '''
  <style>
    p{margin:0;padding:0}
    body{margin:10px}
    body,select{font:13px/normal arial,sans-serif}
    ins{text-decoration:none}
    .css{margin-left:10px}
  </style>
  '''

view.make 'cssProperty', '''((#:style.active))((:style.prop)): ((:style.value));((/))'''

# Option tags & contenteditable must only contain a variable with no additional text
# For validation, non-closed p elements must be wrapped in a div instead of the
# default ins. Closed p's are fine in an ins element.
view.make 'Body', '''
  <select multiple><optgroup label="CSS properties">
    ((#x.styles))<option selected=((.active))>((.prop))((/))
  </select>
  <div>
    ((#x.styles))
      <p><input type=checkbox checked=((.active))> 
      <input value=((.prop)) disabled=!((.active))> 
      <input value=((.value)) disabled=!((.active))>
    ((/))
  </div>
  <button x-bind=click:addStyle>Add</button>
  <h3>Currently applied:</h3>
  <p>{
    <p class=css>((#x.styles :style))((> cssProperty))((#:style.active))<br>((/))((/))
  <p>}
  <h3>Output:</h3>
  <p style="((x.styles :style > cssProperty))" contenteditable>(((x.outputText)))</p>
  '''

exports.addStyle = ->
  model.push 'x.styles', {}
