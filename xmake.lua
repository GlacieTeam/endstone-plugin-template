add_rules("mode.debug", "mode.release")

add_repositories(
    "liteldev-repo https://github.com/LiteLDev/xmake-repo.git",
    "groupmountain-repo https://github.com/GroupMountain/xmake-repo.git"
)

add_requires(
    "endstone 0.6.1",
    "expected-lite 0.8.0",
    "fmt 10.2.1"
    -- "glaciehook 1.0.1",
    -- "libhat 2024.9.22",
    -- "detours v4.0.1-xmake.1"
)

if not has_config("vs_runtime") then
    set_runtimes("MD")
end

target("my-plugin")
    add_defines(
        "NOMINMAX", 
        "UNICODE", 
        "_HAS_CXX23"
    )
    add_packages(
        "fmt",
        "expected-lite",
        "endstone"
        -- "glaciehook",
        -- "libhat",
        -- "detours"
    )
    set_kind("shared")
    set_languages("cxx20")
    set_symbols("debug")
    add_includedirs("src")
    add_files("src/**.cpp")

    if is_plat("windows") then
        add_cxxflags("/Zc:__cplusplus")
        add_cxflags(
            "/EHa", 
            "/utf-8", 
            "/W4"
        )
    elseif is_plat("linux") then
        add_rpathdirs("$ORIGIN/../")
        add_cxflags(
            "-fPIC",
            "-stdlib=libc++",
            "-fdeclspec",
            {force = true}
        )
        add_ldflags(
            "-stdlib=libc++",
            {force = true}
        )
        add_packages("libelf")
        add_syslinks("dl", "pthread", "c++", "c++abi")
    end
    set_exceptions("none") -- To avoid conflicts with /EHa.

    if is_mode("debug") then
        add_defines("DEBUG")
    elseif is_mode("release") then
        add_defines("NDEBUG")
    end

    after_build(function(target)
        local output_dir = path.join(os.projectdir(), "bin")

        os.cp(
            target:targetfile(), 
            path.join(
                output_dir, 
                target:name() .. ".dll"
            )
        )

        local pdb_path = path.join(output_dir, target:name() .. ".pdb")
        if os.isfile(target:symbolfile()) then 
            os.cp(target:symbolfile(), pdb_path) 
        end

        cprint("${bright green}[Plugin]: ${reset}plugin already generated to " .. output_dir)
    end)