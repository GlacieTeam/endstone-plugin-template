#include "MyPlugin.h"

namespace my_plugin {

MyPlugin* MyPlugin::getInstance() {
    static std::unique_ptr<MyPlugin> instance;
    if (!instance) instance = std::make_unique<MyPlugin>();
    return instance.get();
}

MyPlugin::PluginInfo& MyPlugin::PluginInfo::builder() {
    static PluginInfo builder;
    return builder;
}

const endstone::PluginDescription& MyPlugin::getDescription() const { return mDescription; }

MyPlugin::PluginInfo::PluginInfo() {
    prefix      = "CppExamplePlugin";
    description = "C++ Example Plugin";
    website     = "https://github.com/Owner/Repo";
    authors     = {"Me"};
}

void MyPlugin::onLoad() {
    getLogger().debug("Loading...");
    // Code for loading the mod goes here.
}

void MyPlugin::onEnable() {
    getLogger().debug("Enabling...");
    // Code for enabling the mod goes here.
}

void MyPlugin::onDisable() {
    getLogger().debug("Disabling...");
    // Code for disabling the mod goes here.
}

} // namespace my_plugin

extern "C" [[maybe_unused]] ENDSTONE_EXPORT endstone::Plugin* init_endstone_plugin() {
    return my_plugin::MyPlugin::getInstance();
}