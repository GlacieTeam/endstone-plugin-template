add_rules("mode.debug", "mode.release")

add_repositories("groupmountain-repo https://github.com/GroupMountain/xmake-repo.git")

add_requires("endstone 0.10.4")

if is_plat("windows") and not has_config("vs_runtime") then
    set_runtimes("MD")
end

if is_plat("linux") then
    set_toolchains("clang")
end

target("my-plugin")
    set_kind("shared")
    set_languages("cxx23")
    set_prefixname("endstone_")
    add_packages(
        "endstone"
    )
    add_includedirs("src")
    add_files("src/**.cpp")

    if is_plat("windows") then
        add_defines("NOMINMAX")
        add_cxflags(
            "/utf-8", 
            "/W4"
        )
    else
        add_cxflags(
            "-Wall",
            "-stdlib=libc++"
        )
        add_syslinks("libc++.a", "libc++abi.a")
    end

    after_build(function(target)
        local file = target:targetfile()
        local output_dir = path.join(os.projectdir(), "bin")
        os.mkdir(output_dir)
        local filename = path.filename(file)
        os.cp(file, path.join(output_dir, filename))
        cprint("${bright green}[Plugin]: ${reset}plugin already generated to " .. output_dir)
    end)