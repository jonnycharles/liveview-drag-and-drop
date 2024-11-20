export default {
    mounted() {
      this.el.setAttribute('draggable', 'true'); // Ensure only task items are draggable

      this.handleDragStart = (e) => {
        e.dataTransfer.effectAllowed = 'move';
        e.dataTransfer.setData('text/plain', this.el.dataset.taskId);
        this.el.classList.add('opacity-50', 'border-dashed', 'border-2', 'border-gray-400'); // Visual feedback
      };

      this.handleDragEnd = () => {
        this.el.classList.remove('opacity-50', 'border-dashed', 'border-2', 'border-gray-400');
      };

      this.el.addEventListener('dragstart', this.handleDragStart);
      this.el.addEventListener('dragend', this.handleDragEnd);
    },

    destroyed() {
      this.el.removeEventListener('dragstart', this.handleDragStart);
      this.el.removeEventListener('dragend', this.handleDragEnd);
    }
  };
