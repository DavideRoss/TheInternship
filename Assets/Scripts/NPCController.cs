using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class NPCController : MonoBehaviour
{
    public GameObject Player;
    public Material[] Materials;
    public Material[] AccMaterials;
    public GameObject[] Hairs;
    public GameObject[] Accessories;
    public Transform NPCBody;
    public GameObject Baloon;
    public SkinnedMeshRenderer Mesh;
    public Transform HeadJoint;
    public Animator NPCAnimator;

    private bool _targetPlayer = false;
    private PlayerController _playerCtrl;
    private bool _seekPlayer = true;
    private NavMeshAgent _agent;
    private Vector3 _prevPos;

    void Start()
    {
        // Hairs
        GameObject hair = Hairs[Random.Range(0, Hairs.Length)];
        if (hair)
        {
            GameObject obj = Instantiate(hair, HeadJoint);
            obj.GetComponentInChildren<MeshRenderer>().material = AccMaterials[Random.Range(0, AccMaterials.Length)];
        }

        // Acc
        GameObject acc = Accessories[Random.Range(0, Accessories.Length)];
        if (acc)
        {
            GameObject obj = Instantiate(acc, HeadJoint);
            obj.GetComponentInChildren<MeshRenderer>().material = AccMaterials[Random.Range(0, AccMaterials.Length)];
        }

        _playerCtrl = Player.GetComponent<PlayerController>();
        _agent = GetComponent<NavMeshAgent>();

        Material mat = Materials[Random.Range(0, Materials.Length)];
        Mesh.material = mat;

        _prevPos = transform.position;

        Baloon.SetActive(false);
    }

    void Update()
    {
        if (_targetPlayer && _seekPlayer)
        {
            Quaternion newRot = Quaternion.LookRotation(Player.transform.position - transform.position);
            NPCBody.transform.rotation = Quaternion.Lerp(NPCBody.transform.rotation, newRot, 5 * Time.deltaTime);

            float dist = Vector3.Distance(transform.position, Player.transform.position);

            if (dist < 2.5f && !_playerCtrl.IsStunned())
            {
                print("Player Stunned");
                _agent.isStopped = true;
                _playerCtrl.StunPlayer(transform);
                NPCAnimator.SetBool("SeekingPlayer", false);

                EncounterController ctrl = gameObject.AddComponent<EncounterController>();
                ctrl.Player = _playerCtrl;
                ctrl.NPC = this;
            }

            if (dist > 1.5f)
            {
                _agent.destination = _playerCtrl.transform.position;
            }
        }

        Vector3 move = transform.position - _prevPos;
        float speed = move.magnitude / Time.deltaTime;
        _prevPos = transform.position;

        NPCAnimator.SetBool("SeekingPlayer", speed > .01f);
    }

    private void OnTriggerEnter(Collider other) {
        if (other.gameObject.tag == "Player")
        {
            _targetPlayer = true;
        }
    }

    private void OnTriggerExit(Collider other) {
        if (other.gameObject.tag == "Player")
        {
            _targetPlayer = false;
        }
    }

    public void IgnorePlayer() {
        _seekPlayer = false; 
        StartCoroutine(ResetIgnorePlayer());
    }

    IEnumerator ResetIgnorePlayer() {
        yield return new WaitForSeconds(15);
        _seekPlayer = true;
        _agent.isStopped = false;
    }
}
