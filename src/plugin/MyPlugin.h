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
    static MyPlugin* getInstance();

    const endstone::PluginDescription& getDescription() const override;

    void onLoad() override;

    void onEnable() override;

    void onDisable() override;

private:
    PluginInfo mPluginInfo;
};

} // namespace my_plugin