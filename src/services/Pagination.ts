import { ref, computed, Ref } from "vue";

export function usePagination(filteredTools: Ref<Record<string, any>>, itemsPerPage: number) {
    const currentPage = ref(1);

    const totalPages = computed(() =>
        Math.ceil(Object.keys(filteredTools.value).length / itemsPerPage)
    );

    const paginatedTools = computed(() => {
        const start = (currentPage.value - 1) * itemsPerPage;
        const end = start + itemsPerPage;
        return Object.entries(filteredTools.value)
            .slice(start, end)
            .reduce((acc, [key, val]) => ({ ...acc, [key]: val }), {});
    });

    const nextPage = () => {
        if (currentPage.value < totalPages.value) currentPage.value++;
    };

    const prevPage = () => {
        if (currentPage.value > 1) currentPage.value--;
    };

    return {
        paginatedTools,
        totalPages,
        currentPage,
        nextPage,
        prevPage,
    };
}