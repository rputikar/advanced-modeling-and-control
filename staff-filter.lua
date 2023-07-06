-- staff-filter.lua
--

-- Function to find the index of an item in a Lua list
local function FindItemIndex(list, item)
  for i, value in ipairs(list) do
    if value == item then
      return i
    end
  end
  return nil
end

local staff

local capture_meta = {
  Meta = function(meta)
    staff = meta.staff
  end
}

local replace_list = {
  Span = function(span)
    -- if div.classes:includes == "coordinator-from-pandoc" then
    if span.identifier == "coordinator-from-pandoc" then
      local result = pandoc.Inlines({})
      for i, person in ipairs(staff) do
        local name = person.name
        local roles = person.role
        local index = FindItemIndex(roles, "teaching")
        result:insert(pandoc.Span(pandoc.utils.stringify(name)))
        if index then
          result:insert(pandoc.Span(name))
        end
        if i < #staff then
          result:insert(pandoc.Span(pandoc.Str(", ")))
        end
      end
      return result
    end
  end
}

return { capture_meta, replace_list }


-- -- Filter to list people with different roles
-- function ListPeopleWithRoles (meta)
--   -- Check if the 'staff' field exists in the YAML metadata
--   if meta.staff then
--     -- Create a table to store people with their roles
--     local peopleWithRoles = {}
--
--     -- Iterate over each person in the 'staff' list
--     for _, person in ipairs(meta.staff) do
--       -- Iterate over each role of the person
--       for _, role in ipairs(person.role) do
--         -- Check if the role exists in the peopleWithRoles table
--         if not peopleWithRoles[role] then
--           -- If the role doesn't exist, create a new entry with an empty table
--           peopleWithRoles[role] = {}
--         end
--
--         -- Add the person to the role entry
--         table.insert(peopleWithRoles[role], person)
--       end
--     end
--
--     -- Create a new div element
--     local div = pandoc.Div({}, pandoc.Attr("", {"people-with-roles"}))
--
--     -- Iterate over each role and its associated people
--     for role, people in pairs(peopleWithRoles) do
--       -- Create a header for the role
--       local header = pandoc.Header(2, pandoc.Str(role))
--
--       -- Create a list of people with their names
--       local listItems = {}
--       for _, person in ipairs(people) do
--         table.insert(listItems, pandoc.Plain(pandoc.Str(person.name)))
--       end
--       local list = pandoc.BulletList(listItems)
--
--       -- Add the header and list to the div
--       table.insert(div.content, header)
--       table.insert(div.content, list)
--     end
--
--     -- Append the new div element to the existing content
--     table.insert(meta.content, div)
--   end
--
--   return meta
-- end
--
-- -- Apply the filter
-- return {
--   { Meta = ListPeopleWithRoles }
-- }
