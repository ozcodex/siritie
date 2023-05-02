-- Function to load files and folders automatically.
function zero_load(mod_name, file_names)
    -- Obtiene la ruta del mod
    local mod_path = minetest.get_modpath(mod_name)
    for _, name in ipairs(file_names) do
        -- Construye la ruta completa al archivo
        local file_path = mod_path.."/"..name..".lua"
        local folder_path = mod_path.."/"..name.."/"
        -- Verifica si el archivo existe antes de cargarlo
        local file_exists = io.open(file_path, "r")
        if file_exists then
            file_exists:close()
            dofile(file_path)
        end
        -- Verifica si la carpeta existe
        local folder_exists = io.open(folder_path, "r")
        if folder_exists then
            folder_exists:close()
            -- Itera a través de todos los archivos en la carpeta
            for _, file_name in ipairs(minetest.get_dir_list(folder_path, false)) do
                -- Verifica si el archivo tiene una extensión ".lua" antes de cargarlo
                if file_name:sub(-4) == ".lua" then
                    -- Construye la ruta completa al archivo
                    local file_path = folder_path..file_name
                    -- Ejecuta el archivo con "dofile"
                    dofile(file_path)
                end
            end
        end
    end
end
