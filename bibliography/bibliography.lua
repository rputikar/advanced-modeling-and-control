function Pandoc (doc)
  local references = pandoc.utils.references(doc)
  doc.meta.bibliography = nil -- ensure that only books will be used
  doc.blocks = pandoc.Blocks{
    pandoc.Header(1, 'Bibliography'),
    pandoc.Div({}, 'refs')
  }

  return pandoc.utils.citeproc(doc)
end
