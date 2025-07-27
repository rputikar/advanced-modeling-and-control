function Pandoc(doc)
	local title = pandoc.utils.stringify(doc.meta.title or "")
	local subtitle = pandoc.utils.stringify(doc.meta.subtitle or "")

	-- Handle plain or structured author
	local author = ""
	if doc.meta.author then
		if type(doc.meta.author) == "table" and doc.meta.author[1] and doc.meta.author[1].name then
			author = pandoc.utils.stringify(doc.meta.author[1].name)
		else
			author = pandoc.utils.stringify(doc.meta.author)
		end
	end

	local date = pandoc.utils.stringify(doc.meta.date or "")
	local modified = pandoc.utils.stringify(doc.meta["date-modified"] or "")

	local block = pandoc.RawBlock(
		"latex",
		string.format(
			[[
\begin{center}
\Large\textbf{%s}

\vspace{0.5em}
\large %s

\vspace{0.5em}
%s

\vspace{1em}
\textbf{Date:} %s \hspace{2em} \textbf{Modified:} %s
\end{center}
]],
			title,
			subtitle,
			author,
			date,
			modified
		)
	)

	-- Remove default metadata so title block isn't rendered again
	doc.meta.title = nil
	doc.meta.subtitle = nil
	doc.meta.author = nil
	doc.meta.date = nil

	table.insert(doc.blocks, 1, block)
	return doc
end
