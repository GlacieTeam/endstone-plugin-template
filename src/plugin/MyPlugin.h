#pragma once
#include "endstone/plugin/plugin.h"

namespace my_plugin {

class MyPlugin : public endstone::Plugin {
public:
    struct PluginInfo : public endstone::detail::PluginDescriptionBuilder {
        PluginInfo();
        static PluginInfo& builder();
    };

public:
    static MyPlugin* getInstance();

    const endstone::PluginDescription& getDescription() const override;

    void onLoad() override;

    void onEnable() override;

    void onDisable() override;

private:
    endstone::PluginDescription mDescription = PluginInfo::builder().build("my_plugin", "11.45.14");
};

} // namespace my_plugin