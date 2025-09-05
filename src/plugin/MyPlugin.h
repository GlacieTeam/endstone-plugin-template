#pragma once
#include "endstone/plugin/plugin.h"

namespace my_plugin {

class MyPlugin : public endstone::Plugin {
public:
    struct PluginInfo : public endstone::detail::PluginDescriptionBuilder {
        std::string name;
        std::string version;
        PluginInfo();
    };

public:
    MyPlugin()                = default;
    MyPlugin(MyPlugin const&) = delete;
    MyPlugin(MyPlugin&&)      = delete;

    static MyPlugin* getInstance() {
        static auto instance = new MyPlugin();
        return instance;
    }

    const endstone::PluginDescription& getDescription() const override {
        static auto description = PluginInfo().build(mPluginInfo.name, mPluginInfo.version);
        return description;
    }

    void onLoad() override;

    void onEnable() override;

    void onDisable() override;

private:
    PluginInfo mPluginInfo;
};

} // namespace my_plugin