import 'package:dictionary/blocs/word_detail_bloc/word_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordDetailView extends StatefulWidget {
  const WordDetailView({super.key, required this.word, required this.words});

  final String word;
  final List<String> words;
  @override
  State<WordDetailView> createState() => _WordDetailViewState();
}

class _WordDetailViewState extends State<WordDetailView> {
  final _bloc = WordDetailBloc();

  @override
  void initState() {
    super.initState();
    _bloc.setWords(widget.words);
    _bloc.getWord(widget.word);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<WordDetailBloc, WordDetailState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state.error != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'FALHA',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      state.error!,
                      style: const TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _bloc.getWord(widget.word);
                        },
                        child: const Text('Tentar novamente'))
                  ],
                );
              }
              if (state.isLoading || state.word == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.red[200]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.word!.word,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                state.word!.phonetic,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ]),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      if (state.word!.audioUrl.isNotEmpty)
                        Row(
                          children: [
                            InkWell(
                              onTap: _bloc.handleClickPlayerSong,
                              child: const Icon(
                                Icons.play_arrow,
                                size: 64,
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                onChanged: (value) {},
                                value: (state.position != null &&
                                        state.duration != null &&
                                        state.position!.inMilliseconds > 0 &&
                                        state.position!.inMilliseconds <
                                            state.duration!.inMilliseconds)
                                    ? state.position!.inMilliseconds /
                                        state.duration!.inMilliseconds
                                    : 0.0,
                              ),
                            )
                          ],
                        )
                      else
                        const Text('Áudio não disponível'),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Meanings',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          state.isFavoriting
                              ? const SizedBox(
                                  height: 32,
                                  width: 32,
                                  child: CircularProgressIndicator(),
                                )
                              : IconButton(
                                  onPressed: _bloc.toggleFavorite,
                                  icon: Icon(
                                    state.favorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: state.favorite
                                        ? Colors.red
                                        : Colors.black,
                                  ))
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      for (var element in state.word!.meanings) ...{
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "${element.partOfSpeech} - ${element.definition}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        )
                      },
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: OutlinedButton(
                            onPressed: _bloc.handleClickBack,
                            child: const Text('Voltar'),
                          )),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: ElevatedButton(
                            onPressed: _bloc.handleClickNext,
                            child: const Text('Próximo'),
                          ))
                        ],
                      )
                    ]),
              );
            }),
      ),
    );
  }
}
