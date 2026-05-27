const express = require('express');
const cors = require('cors');
const axios = require('axios');

const app = express();
app.use(cors());
app.use(express.json());

const port = process.env.PORT || 3000;

let contatos = [];
let nextCodigo = 1;

// GET /listar
app.get('/listar', (req, res) => {
  res.json(contatos);
});

// POST /cadastrar
app.post('/cadastrar', (req, res) => {
  const {
    nome, email, telefone, nascimento,
    cep, bairro, logradouro, numero, estado, cidade
  } = req.body;

  const contato = {
    codigo: nextCodigo++,
    nome: nome || '',
    email: email || '',
    telefone: telefone || '',
    nascimento: nascimento || '',
    cep: cep || '',
    bairro: bairro || '',
    logradouro: logradouro || '',
    numero: numero || '',
    estado: estado || '',
    cidade: cidade || ''
  };

  contatos.push(contato);
  res.status(201).json(contato);
});

// PUT /alterar/:codigo
app.put('/alterar/:codigo', (req, res) => {
  const codigo = parseInt(req.params.codigo, 10);
  const idx = contatos.findIndex(c => c.codigo === codigo);
  if (idx === -1) return res.status(404).json({ mensagem: 'Contato não encontrado' });

  const campos = req.body;
  contatos[idx] = { ...contatos[idx], ...campos, codigo };
  res.json(contatos[idx]);
});

// DELETE /remover/:codigo
app.delete('/remover/:codigo', (req, res) => {
  const codigo = parseInt(req.params.codigo, 10);
  const exists = contatos.some(c => c.codigo === codigo);
  if (!exists) return res.status(404).json({ mensagem: 'Contato não encontrado' });

  contatos = contatos.filter(c => c.codigo !== codigo);
  res.json({ mensagem: 'Contato removido com sucesso!' });
});

// NEW: GET /cep/:cep -> ViaCEP lookup
app.get('/cep/:cep', async (req, res) => {
  const cepRaw = (req.params.cep || '').toString().replace(/\D/g, '');
  if (cepRaw.length !== 8) return res.status(400).json({ mensagem: 'CEP inválido' });

  try {
    const resp = await axios.get(`https://viacep.com.br/ws/${cepRaw}/json/`);
    const data = resp.data;
    if (data.erro) return res.status(404).json({ mensagem: 'CEP não encontrado' });

    // Normalize response to client
    return res.json({
      cep: data.cep || '',
      logradouro: data.logradouro || '',
      complemento: data.complemento || '',
      bairro: data.bairro || '',
      localidade: data.localidade || '',
      uf: data.uf || ''
    });
  } catch (err) {
    return res.status(502).json({ mensagem: 'Erro ao consultar ViaCEP' });
  }
});

app.listen(port, () => {
  console.log(`API de contatos rodando na porta ${port}`);
})