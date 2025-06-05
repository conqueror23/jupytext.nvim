local M = {}

local language_extensions = {
  python = "py",
  julia = "jl",
  r = "r",
  R = "r",
  bash = "sh",
}

local language_names = {
  python3 = "python",
}

M.get_ipynb_metadata = function(filename)
  local metadata = vim.json.decode(io.open(filename, "r"):read "a")["metadata"]
  local kernelspec = (metadata and metadata.kernelspec)
    or {
      name = "python3",
      language = "python3",
    }
  local language = kernelspec.language
  if language == nil then
    language = language_names[kernelspec.name]
  end
  local extension = language_extensions[language]

  return { language = language, extension = extension }
end

M.get_jupytext_file = function(filename, extension)
  local jupytext = metadata and metadata.jupytext
  if not jupytext or type(jupytext.formats) ~= "string" then
    return "md"
  end

  local fileroot = vim.fn.fnamemodify(filename, ":r")
  return fileroot .. "." .. extension
end

M.check_key = function(tbl, key)
  for tbl_key, _ in pairs(tbl) do
    if tbl_key == key then
      return true
    end
  end

  return false
end

return M
