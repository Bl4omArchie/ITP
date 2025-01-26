import { computed, ref } from "vue";

export function usePagination(items: any, itemsPerPage: number) {
    const currentPage = ref(1);

    const totalPages = computed(() => Math.ceil(Object.keys(items.value).length / itemsPerPage));

    const paginatedItems = computed(() => {
        const start = (currentPage.value - 1) * itemsPerPage;
        const end = start + itemsPerPage;
        return Object.entries(items.value)
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
        currentPage,
        totalPages,
        paginatedItems,
        nextPage,
        prevPage,
    };
}