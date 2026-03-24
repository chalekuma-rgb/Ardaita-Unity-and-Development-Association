{{flutter_js}}
{{flutter_build_config}}

const loadingElement = document.getElementById('loading');

_flutter.loader.load({
  onEntrypointLoaded: async function (engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();

    if (loadingElement) {
      loadingElement.remove();
    }

    await appRunner.runApp();
  }
});
