import { getCurrentInstance } from 'vue';

export default function useEmitter(): any {
    const internalInstance = getCurrentInstance() as { appContext: { config: { globalProperties: Record<string, any> } } };
    const emitter = internalInstance.appContext.config.globalProperties.emitter;
    return emitter;
}