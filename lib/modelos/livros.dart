class Livros {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final int likes;
  final String description;
  final int pages;
  final double rating;
  final String genre;

  Livros({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.likes,
    this.description = '',
    this.pages = 0,
    this.rating = 0.0,
    this.genre = '',
  });

  static List<Livros> getSampleBooks() {
    return [
      Livros(
        id: 1,
        title: '1984',
        author: 'George Orwell',
        coverUrl:
            'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=400&h=600&fit=crop',
        likes: 3785,
        description:
            'Uma distopia clássica sobre totalitarismo e vigilância. Winston Smith vive em uma sociedade opressiva onde o Grande Irmão vigia cada movimento.',
        pages: 328,
        rating: 4.8,
        genre: 'Ficção Científica',
      ),
      Livros(
        id: 2,
        title: 'Crime e Castigo',
        author: 'Dostoiévski',
        coverUrl:
            'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=400&h=600&fit=crop',
        likes: 8600,
        description:
            'Um jovem estudante comete um assassinato e mergulha em um turbilhão psicológico de culpa e redenção.',
        pages: 671,
        rating: 4.9,
        genre: 'Romance Psicológico',
      ),
      Livros(
        id: 3,
        title: 'Harry Potter',
        author: 'J.K. Rowling',
        coverUrl:
            'https://images.unsplash.com/photo-1621351183012-e2f9972dd9bf?w=400&h=600&fit=crop',
        likes: 12357,
        description:
            'Um jovem bruxo descobre seu destino mágico e enfrenta o bruxo das trevas mais perigoso de todos os tempos.',
        pages: 309,
        rating: 4.7,
        genre: 'Fantasia',
      ),
      Livros(
        id: 4,
        title: 'O Senhor dos Anéis',
        author: 'J.R.R. Tolkien',
        coverUrl:
            'https://images.unsplash.com/photo-1531346374200-2dc3a41dc0b0?w=400&h=600&fit=crop',
        likes: 15420,
        description: 'Uma épica aventura de fantasia pela Terra Média.',
        pages: 1178,
        rating: 4.9,
        genre: 'Fantasia',
      ),
      Livros(
        id: 5,
        title: 'Dom Casmurro',
        author: 'Machado de Assis',
        coverUrl:
            'https://images.unsplash.com/photo-1524578271613-d550eacf6090?w=400&h=600&fit=crop',
        likes: 7234,
        description: 'Um clássico brasileiro sobre ciúmes e dúvida.',
        pages: 256,
        rating: 4.5,
        genre: 'Romance',
      ),
    ];
  }
}
